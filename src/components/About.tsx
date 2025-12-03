import { Card, CardContent } from "@/components/ui/card";
import { Users, Heart, Lightbulb } from "lucide-react";

export const About = () => {
  return (
    <section id="about" className="py-20 md:py-32 bg-background">
      <div className="container mx-auto px-4">
        <div className="max-w-4xl mx-auto text-center space-y-6 mb-16">
          <h2 className="font-display text-3xl md:text-5xl font-bold text-foreground">
            About <span className="text-gradient">Nazma Trust</span>
          </h2>
          <p className="text-lg md:text-xl text-muted-foreground leading-relaxed">
            Founded by Kaosar Ahmed with initial trustees Imrana Begum and Farhana Begum, Nazma Social Development Trust was established under the Indian Trusts Act, 1882. Our vision is to create long-term empowerment, welfare, and innovation for communities across Nagaland and beyond.
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-8 max-w-6xl mx-auto">
          <Card className="shadow-card hover:shadow-medium transition-smooth border-border/50">
            <CardContent className="p-8 text-center space-y-4">
              <div className="w-16 h-16 mx-auto rounded-full bg-primary/10 flex items-center justify-center">
                <Users className="w-8 h-8 text-primary" />
              </div>
              <h3 className="font-display text-xl font-semibold text-foreground">
                Community Focused
              </h3>
              <p className="text-muted-foreground">
                Dedicated to empowering local communities through sustainable development and inclusive programs.
              </p>
            </CardContent>
          </Card>

          <Card className="shadow-card hover:shadow-medium transition-smooth border-border/50">
            <CardContent className="p-8 text-center space-y-4">
              <div className="w-16 h-16 mx-auto rounded-full bg-secondary/10 flex items-center justify-center">
                <Heart className="w-8 h-8 text-secondary" />
              </div>
              <h3 className="font-display text-xl font-semibold text-foreground">
                Compassionate Care
              </h3>
              <p className="text-muted-foreground">
                Supporting the most vulnerable members of society with dignity, respect, and genuine care.
              </p>
            </CardContent>
          </Card>

          <Card className="shadow-card hover:shadow-medium transition-smooth border-border/50">
            <CardContent className="p-8 text-center space-y-4">
              <div className="w-16 h-16 mx-auto rounded-full bg-accent/10 flex items-center justify-center">
                <Lightbulb className="w-8 h-8 text-accent" />
              </div>
              <h3 className="font-display text-xl font-semibold text-foreground">
                Innovation Driven
              </h3>
              <p className="text-muted-foreground">
                Promoting science, technology, and creative solutions to address social challenges.
              </p>
            </CardContent>
          </Card>
        </div>
      </div>
    </section>
  );
};
