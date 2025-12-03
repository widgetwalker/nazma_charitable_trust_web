import { Button } from "@/components/ui/button";
import heroImage from "@/assets/hero-community.jpg";

export const Hero = () => {
  const scrollToSection = (href: string) => {
    const element = document.querySelector(href);
    if (element) {
      element.scrollIntoView({ behavior: "smooth" });
    }
  };

  return (
    <section id="home" className="relative min-h-screen flex items-center justify-center overflow-hidden">
      {/* Background Image with Overlay */}
      <div className="absolute inset-0 z-0">
        <img
          src={heroImage}
          alt="Community empowerment"
          className="w-full h-full object-cover"
        />
        <div className="absolute inset-0 bg-gradient-to-br from-primary/40 via-secondary/30 to-background/50" />
      </div>

      {/* Content */}
      <div className="container mx-auto px-4 relative z-10 text-center pt-20">
        <div className="max-w-4xl mx-auto space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-1000">
          <h1 className="font-display text-4xl md:text-6xl lg:text-7xl font-bold text-white leading-tight">
            Empowering Women,{" "}
            <span className="text-accent">Supporting Elders</span>,{" "}
            Promoting Innovation
          </h1>
          <p className="text-lg md:text-xl lg:text-2xl text-white/90 max-w-3xl mx-auto leading-relaxed">
            Dedicated to women's welfare, elderly support, science innovation, and general social welfare through education, health, environment, and disaster relief.
          </p>
          <div className="flex flex-col sm:flex-row items-center justify-center gap-4 pt-4">
            <Button
              variant="hero"
              size="xl"
              onClick={() => scrollToSection("#about")}
            >
              Learn More
            </Button>
            <Button
              variant="outline"
              size="xl"
              onClick={() => scrollToSection("#involved")}
              className="bg-white/10 backdrop-blur-sm text-white border-white hover:bg-white hover:text-foreground"
            >
              Get Involved
            </Button>
            <Button
              variant="cta"
              size="xl"
              onClick={() => scrollToSection("#involved")}
            >
              Donate Now
            </Button>
          </div>
        </div>
      </div>

      {/* Scroll Indicator */}
      <div className="absolute bottom-8 left-1/2 -translate-x-1/2 z-10 animate-bounce">
        <div className="w-6 h-10 rounded-full border-2 border-white/50 flex items-start justify-center p-2">
          <div className="w-1.5 h-3 bg-white/50 rounded-full" />
        </div>
      </div>
    </section>
  );
};
