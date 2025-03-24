import os
import sys
from typing import List, Dict, Any, Optional

from langchain_core.runnables import (
    Runnable,
    RunnablePassthrough,
)
from langchain_core.prompts import ChatPromptTemplate, MessagesPlaceholder
from langchain_core.output_parsers import StrOutputParser
from langchain_openai import ChatOpenAI

from langchain.memory import (
    ConversationBufferMemory
)

from langchain_community.document_loaders import TextLoader
from langchain_text_splitters import CharacterTextSplitter
from langchain_community.vectorstores import FAISS
from langchain_openai import OpenAIEmbeddings

from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()


class SimpleRAGAgent:
    """
    A simple conversational agent that uses Retrieval-Augmented Generation (RAG)
    to provide answers based on a knowledge base.
    """

    def __init__(self, knowledge_base_path: str = "knowledge_base.txt"):
        """
        Initialize the agent with a language model and a knowledge base.

        Args:
            knowledge_base_path: Path to the knowledge base text file
        """
        # Check if OpenAI API key is set
        if not os.getenv("OPENAI_API_KEY"):
            raise ValueError(
                "OPENAI_API_KEY environment variable is not set. Please add it to your .env file.")

        # Initialize language model
        self.llm = ChatOpenAI(
            model="gpt-3.5-turbo",
            temperature=0.7
        )

        # Path to knowledge base
        self.knowledge_base_path = knowledge_base_path

        # Create vector store from knowledge base
        self.vector_store = self._create_vector_store()

        # Initialize conversation memory
        self.memory = ConversationBufferMemory(
            return_messages=True,
            memory_key="chat_history"
        )

        # Create conversation chain
        self.conversation_chain = self._create_conversation_chain()

    def _create_vector_store(self):
        """Create a vector store from the knowledge base text file."""
        try:
            # Check if the file exists
            if not os.path.exists(self.knowledge_base_path):
                raise FileNotFoundError(
                    f"File not found: {self.knowledge_base_path}")

            # Load the text file
            loader = TextLoader(self.knowledge_base_path)
            documents = loader.load()

            # Split the text into chunks
            text_splitter = CharacterTextSplitter(
                chunk_size=1000,
                chunk_overlap=200
            )
            texts = text_splitter.split_documents(documents)

            # Create embeddings and vector store
            embeddings = OpenAIEmbeddings()
            vector_store = FAISS.from_documents(texts, embeddings)

            print(
                f"Successfully loaded knowledge base with {len(texts)} text chunks")
            return vector_store

        except Exception as e:
            print(f"Error creating vector store: {str(e)}")
            sys.exit(1)

    def _create_conversation_chain(self) -> Runnable:
        """Create the conversation chain with RAG integration."""
        # Define system prompt
        system_prompt = """
        You are an AI Sales Agent designed to assist customers with product inquiries, recommendations, and basic sales interactions. 
        
        ## ROLE & OBJECTIVE:
        - Act as a friendly and persuasive virtual sales representative.
        - Engage users in a natural, conversational manner.
        - Understand customer needs and provide suitable product recommendations.
        - Assist with pricing, availability, and general product details.
        - Handle common sales objections and guide users toward making a purchase decision.
        
        ## GUIDELINES:
        - Maintain a polite, engaging, and helpful tone.
        - Ask clarifying questions to understand customer preferences before recommending products.
        - Highlight product benefits and unique selling points.
        - Provide clear and concise responses with a focus on assisting the customer.
        - If unsure about an answer, acknowledge it and redirect the customer appropriately.
        - Avoid repeating information unnecessarily and adapt based on the conversation history.
        
        ## CONVERSATION SCENARIOS:
        - **Scenario 1:** A customer asks about a specific product and its features.
        - **Scenario 2:** A customer is unsure what to buy and needs personalized recommendations.
        - **Scenario 3:** A customer raises concerns about price, quality, or availability, and you help address their objections.
        
        ## KNOWLEDGE BASE CONTEXT:
        {context}
        
        ## CONVERSATION HISTORY:
        Remember what has been discussed to provide a seamless and coherent conversation flow.
        """

        # Create prompt template
        prompt = ChatPromptTemplate.from_messages([
            ("system", system_prompt),
            MessagesPlaceholder(variable_name="chat_history"),
            ("human", "{input}")
        ])

        # Function to format documents
        def format_docs(docs):
            return "\n\n".join(doc.page_content for doc in docs)

        # Create retriever
        retriever = self.vector_store.as_retriever(
            search_type="similarity",
            search_kwargs={"k": 3}
        )

        # Create conversation chain
        rag_chain = (
            RunnablePassthrough.assign(
                context=lambda x: format_docs(
                    retriever.get_relevant_documents(x["input"]))
            )
            | prompt
            | self.llm
            | StrOutputParser()
        )

        return rag_chain

    def process_message(self, message: str) -> str:
        """
        Process a user message and return a response.

        Args:
            message: The user's message

        Returns:
            The agent's response
        """
        try:
            # Prepare the input with chat history
            chain_input = {
                "input": message,
                "chat_history": self.memory.chat_memory.messages
            }

            # Get response from conversation chain
            response = self.conversation_chain.invoke(chain_input)

            # Update memory with the conversation turn
            self.memory.chat_memory.add_user_message(message)
            self.memory.chat_memory.add_ai_message(response)

            return response

        except Exception as e:
            error_msg = f"Error processing message: {str(e)}"
            print(error_msg)
            return "I apologize, but I encountered an issue processing your request. Please try again."

    def run_terminal_interface(self):
        """Run a simple terminal interface for interacting with the agent."""
        print("Simple RAG Agent Terminal Interface")
        print("Type 'exit' or 'quit' to end the conversation")
        print("-" * 50)

        while True:
            # Get user input
            user_input = input("\nYou: ")

            # Check if user wants to exit
            if user_input.lower() in ["exit", "quit"]:
                print("Goodbye!")
                break

            # Process the message and get response
            response = self.process_message(user_input)

            # Display the response
            print(f"\nAgent: {response}")


if __name__ == "__main__":
    # Get knowledge base path from command line argument or use default
    kb_path = sys.argv[1] if len(sys.argv) > 1 else "knowledge_base.txt"

    # Create and run the agent
    agent = SimpleRAGAgent(knowledge_base_path=kb_path)
    agent.run_terminal_interface()
