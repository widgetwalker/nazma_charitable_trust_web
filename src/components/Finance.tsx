import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { DollarSign, TrendingUp, FileText, Shield } from "lucide-react";

export const Finance = () => {
  return (
    <section id="finance" className="py-20 md:py-32 bg-background">
      <div className="container mx-auto px-4">
        <div className="text-center space-y-4 mb-16">
          <h2 className="font-display text-3xl md:text-5xl font-bold text-foreground">
            Financial <span className="text-gradient">Transparency</span>
          </h2>
          <p className="text-lg md:text-xl text-muted-foreground max-w-3xl mx-auto">
            Building trust through complete financial accountability
          </p>
        </div>

        <div className="max-w-4xl mx-auto space-y-8">
          <Card className="shadow-card border-border/50 bg-gradient-to-br from-primary/5 to-secondary/5">
            <CardContent className="p-8">
              <div className="grid md:grid-cols-2 gap-8">
                <div className="space-y-4">
                  <div className="flex items-start gap-3">
                    <div className="w-12 h-12 rounded-lg bg-primary/10 flex items-center justify-center flex-shrink-0">
                      <DollarSign className="w-6 h-6 text-primary" />
                    </div>
                    <div>
                      <h3 className="font-display text-lg font-semibold text-foreground mb-2">
                        Initial Corpus
                      </h3>
                      <p className="text-muted-foreground">
                        Trust established with an initial corpus of ₹2,000, demonstrating our commitment to sustainable growth.
                      </p>
                    </div>
                  </div>
                </div>

                <div className="space-y-4">
                  <div className="flex items-start gap-3">
                    <div className="w-12 h-12 rounded-lg bg-secondary/10 flex items-center justify-center flex-shrink-0">
                      <TrendingUp className="w-6 h-6 text-secondary" />
                    </div>
                    <div>
                      <h3 className="font-display text-lg font-semibold text-foreground mb-2">
                        Fund Utilization
                      </h3>
                      <p className="text-muted-foreground">
                        100% of income is applied directly to charitable objectives, ensuring maximum impact for our beneficiaries.
                      </p>
                    </div>
                  </div>
                </div>

                <div className="space-y-4">
                  <div className="flex items-start gap-3">
                    <div className="w-12 h-12 rounded-lg bg-accent/10 flex items-center justify-center flex-shrink-0">
                      <FileText className="w-6 h-6 text-accent" />
                    </div>
                    <div>
                      <h3 className="font-display text-lg font-semibold text-foreground mb-2">
                        Annual Reports
                      </h3>
                      <p className="text-muted-foreground">
                        Detailed financial statements and impact reports published annually for complete transparency.
                      </p>
                    </div>
                  </div>
                </div>

                <div className="space-y-4">
                  <div className="flex items-start gap-3">
                    <div className="w-12 h-12 rounded-lg bg-primary/10 flex items-center justify-center flex-shrink-0">
                      <Shield className="w-6 h-6 text-primary" />
                    </div>
                    <div>
                      <h3 className="font-display text-lg font-semibold text-foreground mb-2">
                        Audit & Compliance
                      </h3>
                      <p className="text-muted-foreground">
                        Regular audits and full compliance with all statutory requirements and governance standards.
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            </CardContent>
          </Card>

          <div className="text-center">
            <Badge variant="secondary" className="px-6 py-2 text-sm">
              Registered under the Indian Trusts Act, 1882
            </Badge>
          </div>
        </div>
      </div>
    </section>
  );
};
