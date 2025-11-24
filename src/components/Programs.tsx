import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import womenImage from "@/assets/women-empowerment.jpg";
import elderlyImage from "@/assets/elderly-support.jpg";
import stemImage from "@/assets/stem-workshop.jpg";

const programs = [
  {
    title: "Women Skill Training",
    description: "Comprehensive vocational training programs in tailoring, crafts, and entrepreneurship, helping women build sustainable livelihoods and financial independence.",
    image: womenImage,
    impact: "200+ women trained",
    category: "Empowerment",
  },
  {
    title: "Elderly Support Groups",
    description: "Regular community gatherings, healthcare support, and social activities creating a supportive network for senior citizens to maintain active and fulfilling lives.",
    image: elderlyImage,
    impact: "150+ seniors supported",
    category: "Care",
  },
  {
    title: "STEM Workshops",
    description: "Hands-on science, technology, engineering, and mathematics programs inspiring young minds to innovate and develop problem-solving skills for the future.",
    image: stemImage,
    impact: "500+ students reached",
    category: "Education",
  },
];

export const Programs = () => {
  return (
    <section id="programs" className="py-20 md:py-32 bg-muted/30">
      <div className="container mx-auto px-4">
        <div className="text-center space-y-4 mb-16">
          <h2 className="font-display text-3xl md:text-5xl font-bold text-foreground">
            Activities & <span className="text-gradient">Programs</span>
          </h2>
          <p className="text-lg md:text-xl text-muted-foreground max-w-3xl mx-auto">
            Real impact through dedicated programs and community initiatives
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-8 max-w-6xl mx-auto">
          {programs.map((program, index) => (
            <Card
              key={index}
              className="overflow-hidden shadow-card hover:shadow-medium transition-smooth border-border/50 group"
            >
              <div className="h-56 overflow-hidden relative">
                <img
                  src={program.image}
                  alt={program.title}
                  className="w-full h-full object-cover group-hover:scale-110 transition-smooth duration-500"
                />
                <div className="absolute top-4 right-4">
                  <Badge variant="secondary" className="bg-white/90 backdrop-blur-sm">
                    {program.category}
                  </Badge>
                </div>
              </div>
              <CardHeader>
                <CardTitle className="font-display text-xl">
                  {program.title}
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <p className="text-muted-foreground leading-relaxed">
                  {program.description}
                </p>
                <div className="pt-2 border-t border-border">
                  <p className="text-sm font-semibold text-primary">
                    {program.impact}
                  </p>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    </section>
  );
};
