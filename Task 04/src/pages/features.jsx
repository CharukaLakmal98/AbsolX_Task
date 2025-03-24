import React from "react";
import {
  Brain,
  Rocket,
  Clock,
  Sparkles,
  Zap,
  Shield,
  Users,
  LineChart,
} from "lucide-react";

function Features() {
  const features = [
    {
      icon: <Rocket className="h-6 w-6 text-white" />,
      title: "AI-Powered Automation",
      description:
        "Automate your workflow with intelligent AI that learns and adapts to your working style.",
    },
    {
      icon: <Clock className="h-6 w-6 text-white" />,
      title: "Time Tracking",
      description:
        "Smart time tracking that automatically categorizes your tasks and provides insights.",
    },
    {
      icon: <Sparkles className="h-6 w-6 text-white" />,
      title: "Smart Suggestions",
      description:
        "Get personalized suggestions to optimize your workflow and boost productivity.",
    },
    {
      icon: <Brain className="h-6 w-6 text-white" />,
      title: "AI Learning",
      description:
        "Our AI continuously learns from your patterns to provide better recommendations.",
    },
    {
      icon: <Zap className="h-6 w-6 text-white" />,
      title: "Quick Actions",
      description:
        "Execute complex workflows with a single click using our smart action system.",
    },
    {
      icon: <Shield className="h-6 w-6 text-white" />,
      title: "Enterprise Security",
      description:
        "Bank-grade encryption and security measures to protect your sensitive data.",
    },
    {
      icon: <Users className="h-6 w-6 text-white" />,
      title: "Team Collaboration",
      description:
        "Seamlessly work together with your team using our collaborative features.",
    },
    {
      icon: <LineChart className="h-6 w-6 text-white" />,
      title: "Analytics Dashboard",
      description:
        "Comprehensive analytics to track your team's productivity and progress.",
    },
  ];

  return (
    <div className="min-h-screen bg-gradient-to-b from-slate-50 to-white pt-24">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center">
          <h1 className="text-4xl font-extrabold text-gray-900 sm:text-5xl md:text-6xl">
            Powerful Features
          </h1>
          <p className="mt-3 max-w-2xl mx-auto text-xl text-gray-500 sm:mt-4">
            Everything you need to supercharge your productivity and streamline
            your workflow
          </p>
        </div>

        <div className="mt-16 grid grid-cols-1 gap-8 sm:grid-cols-2 lg:grid-cols-3">
          {features.map((feature, index) => (
            <div key={index} className="pt-6">
              <div className="flow-root bg-white rounded-lg px-6 pb-8 shadow-lg hover:shadow-xl transition-shadow duration-300">
                <div className="-mt-6">
                  <div className="inline-flex items-center justify-center p-3 bg-purple-600 rounded-md shadow-lg">
                    {feature.icon}
                  </div>
                  <h3 className="mt-8 text-lg font-medium text-gray-900 tracking-tight">
                    {feature.title}
                  </h3>
                  <p className="mt-5 text-base text-gray-500">
                    {feature.description}
                  </p>
                </div>
              </div>
            </div>
          ))}
        </div>

        <div className="mt-20 text-center">
          <h2 className="text-3xl font-extrabold text-gray-900">
            Ready to transform your workflow?
          </h2>
          <div className="mt-8">
            <a
              href="/pricing"
              className="inline-flex items-center justify-center px-8 py-3 border border-transparent text-base font-medium rounded-md text-white bg-purple-600 hover:bg-purple-700 md:py-4 md:text-lg md:px-10"
            >
              View Pricing
            </a>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Features;
