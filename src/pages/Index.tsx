import { Navbar } from "@/components/Navbar";
import { Hero } from "@/components/Hero";
import { About } from "@/components/About";
import { Objectives } from "@/components/Objectives";
import { Governance } from "@/components/Governance";
import { Programs } from "@/components/Programs";
import { Finance } from "@/components/Finance";
import { GetInvolved } from "@/components/GetInvolved";
import { Contact } from "@/components/Contact";
import { Footer } from "@/components/Footer";

const Index = () => {
  return (
    <div className="min-h-screen">
      <Navbar />
      <Hero />
      <About />
      <Objectives />
      <Governance />
      <Programs />
      <Finance />
      <GetInvolved />
      <Contact />
      <Footer />
    </div>
  );
};

export default Index;
