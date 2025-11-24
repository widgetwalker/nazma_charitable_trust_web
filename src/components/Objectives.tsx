import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import womenImage from "@/assets/indian-women-empowerment.jpg";
import elderlyImage from "@/assets/indian-elderly-support.jpg";
import stemImage from "@/assets/indian-stem-workshop.jpg";
import generalWelfareImage from "@/assets/indian-general-welfare.jpg";

const objectives = [
  {
    title: "Women's Welfare & Empowerment",
    icon: "👩",
    description: "Skill development programs, vocational training, and entrepreneurship support to empower women economically and socially.",
    image: womenImage,
    color: "bg-primary/10 border-primary/20",
  },
  {
    title: "Support for the Elderly",
    icon: "🤝",
    description: "Community support groups, healthcare assistance, and social engagement programs ensuring dignity and care for senior citizens.",
    image: elderlyImage,
    color: "bg-secondary/10 border-secondary/20",
  },
  {
    title: "Promotion of Science & Innovation",
    icon: "🔬",
    description: "STEM workshops, innovation labs, and educational programs fostering scientific thinking and technological advancement.",
    image: stemImage,
    color: "bg-accent/10 border-accent/20",
  },
  {
    title: "General Social Welfare",
    icon: "🌍",
    description: "Comprehensive initiatives in education, healthcare, environmental conservation, and disaster relief for community wellbeing.",
    image: generalWelfareImage,
    color: "bg-muted border-border",
  },
];

export const Objectives = () => {
  return (
    <section id="objectives" className="py-20 md:py-32 bg-muted/30">
      <div className="container mx-auto px-4">
        <div className="text-center space-y-4 mb-16">
          <h2 className="font-display text-3xl md:text-5xl font-bold text-foreground">
            Our <span className="text-gradient">Objectives</span>
          </h2>
          <p className="text-lg md:text-xl text-muted-foreground max-w-3xl mx-auto">
            Four pillars of impact driving positive change in our communities
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-8 max-w-6xl mx-auto">
          {objectives.map((objective, index) => (
            <Card
              key={index}
              className={`overflow-hidden shadow-card hover:shadow-medium transition-smooth ${objective.color}`}
            >
              {objective.image && (
                <div className="h-48 overflow-hidden">
                  <img
                    src={objective.image}
                    alt={objective.title}
                    className="w-full h-full object-cover hover:scale-105 transition-smooth duration-500"
                  />
                </div>
              )}
              <CardHeader>
                <CardTitle className="flex items-center gap-3 text-2xl">
                  <span className="text-4xl">{objective.icon}</span>
                  <span className="font-display">{objective.title}</span>
                </CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-muted-foreground leading-relaxed">
                  {objective.description}
                </p>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    </section>
  );
};
