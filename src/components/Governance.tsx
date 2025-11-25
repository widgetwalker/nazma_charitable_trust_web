import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Linkedin } from "lucide-react";
import kaosarImage from "@/assets/kaosar-ahmed.png";
import imranaImage from "@/assets/imrana-begum.jpg";

const trustees = [
  {
    name: "Kaosar Ahmed",
    role: "Founder & Trustee",
    bio: "Visionary founder dedicated to social development and community empowerment with years of experience in nonprofit leadership.",
    image: kaosarImage,
    linkedin: "https://www.linkedin.com/in/kaosar-ahmed-31bba0223",
  },
  {
    name: "Imrana Begum",
    role: "Chairman",
    bio: "Passionate advocate for women's rights and education, bringing extensive knowledge in community development and social welfare.",
    image: imranaImage,
  },
  {
    name: "Farhana Begum",
    role: "Trustee",
    bio: "Committed to elderly care and healthcare initiatives, with a strong background in social services and community outreach.",
  },
];

export const Governance = () => {
  return (
    <section id="governance" className="py-20 md:py-32 bg-background">
      <div className="container mx-auto px-4">
        <div className="text-center space-y-4 mb-16">
          <h2 className="font-display text-3xl md:text-5xl font-bold text-foreground">
            Our <span className="text-gradient">Governance</span>
          </h2>
          <p className="text-lg md:text-xl text-muted-foreground max-w-3xl mx-auto">
            Transparent leadership committed to accountability and impact
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-8 max-w-6xl mx-auto mb-12">
          {trustees.map((trustee, index) => (
            <Card
              key={index}
              className="shadow-card hover:shadow-medium transition-smooth border-border/50"
            >
              <CardHeader>
                {trustee.image ? (
                  <div className="w-24 h-24 mx-auto mb-4 rounded-full overflow-hidden border-4 border-primary/20">
                    <img
                      src={trustee.image}
                      alt={trustee.name}
                      className="w-full h-full object-cover"
                    />
                  </div>
                ) : (
                  <div className="w-24 h-24 mx-auto mb-4 rounded-full bg-gradient-to-br from-primary to-secondary flex items-center justify-center text-white text-3xl font-bold">
                    {trustee.name.charAt(0)}
                  </div>
                )}
                <CardTitle className="text-center">
                  <div className="font-display text-xl font-semibold">
                    {trustee.name}
                  </div>
                  <Badge variant="secondary" className="mt-2">
                    {trustee.role}
                  </Badge>
                </CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-muted-foreground text-center leading-relaxed">
                  {trustee.bio}
                </p>
                {trustee.linkedin && (
                  <div className="mt-4 flex justify-center">
                    <a
                      href={trustee.linkedin}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="inline-flex items-center gap-2 text-primary hover:text-primary/80 transition-smooth"
                    >
                      <Linkedin className="w-4 h-4" />
                      <span className="text-sm">LinkedIn Profile</span>
                    </a>
                  </div>
                )}
              </CardContent>
            </Card>
          ))}
        </div>

        <div className="max-w-4xl mx-auto">
          <Card className="shadow-card border-border/50 bg-muted/30">
            <CardContent className="p-8 space-y-4">
              <h3 className="font-display text-xl font-semibold text-foreground text-center mb-4">
                Governance Structure
              </h3>
              <div className="grid md:grid-cols-2 gap-6 text-muted-foreground">
                <div>
                  <p className="font-semibold text-foreground mb-2">Roles & Responsibilities</p>
                  <p>Trustee roles rotate annually among Chairman, Secretary, and Treasurer to ensure shared leadership and diverse perspectives.</p>
                </div>
                <div>
                  <p className="font-semibold text-foreground mb-2">Decision Making</p>
                  <p>All decisions are made by consensus or majority vote with proper quorum rules, ensuring democratic and transparent governance.</p>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </section>
  );
};
