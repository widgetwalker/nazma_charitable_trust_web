import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { HandHeart, Users, Heart } from "lucide-react";
import qrCode from "@/assets/phonepe-qr.jpg";

export const GetInvolved = () => {
  const [showQrDialog, setShowQrDialog] = useState(false);
  
  const scrollToContact = () => {
    const element = document.querySelector("#contact");
    if (element) {
      element.scrollIntoView({ behavior: "smooth" });
    }
  };

  return (
    <section id="involved" className="py-20 md:py-32 bg-muted/30">
      <div className="container mx-auto px-4">
        <div className="text-center space-y-4 mb-16">
          <h2 className="font-display text-3xl md:text-5xl font-bold text-foreground">
            Get <span className="text-gradient">Involved</span>
          </h2>
          <p className="text-lg md:text-xl text-muted-foreground max-w-3xl mx-auto">
            Join us in making a difference in our communities
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-8 max-w-6xl mx-auto">
          <Card className="shadow-card hover:shadow-medium transition-smooth border-border/50 text-center">
            <CardHeader>
              <div className="w-16 h-16 mx-auto mb-4 rounded-full bg-primary/10 flex items-center justify-center">
                <HandHeart className="w-8 h-8 text-primary" />
              </div>
              <CardTitle className="font-display text-2xl">Volunteer</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <p className="text-muted-foreground">
                Share your time and skills to support our programs and make a direct impact in the community.
              </p>
              <Button
                variant="outline"
                className="w-full"
                onClick={scrollToContact}
              >
                Sign Up
              </Button>
            </CardContent>
          </Card>

          <Card className="shadow-card hover:shadow-medium transition-smooth border-border/50 text-center">
            <CardHeader>
              <div className="w-16 h-16 mx-auto mb-4 rounded-full bg-secondary/10 flex items-center justify-center">
                <Users className="w-8 h-8 text-secondary" />
              </div>
              <CardTitle className="font-display text-2xl">Partner</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <p className="text-muted-foreground">
                Collaborate with us on programs and initiatives that align with your organization's mission.
              </p>
              <Button
                variant="outline"
                className="w-full"
                onClick={scrollToContact}
              >
                Learn More
              </Button>
            </CardContent>
          </Card>

          <Card className="shadow-card hover:shadow-medium transition-smooth border-border/50 text-center">
            <CardHeader>
              <div className="w-16 h-16 mx-auto mb-4 rounded-full bg-accent/10 flex items-center justify-center">
                <Heart className="w-8 h-8 text-accent" />
              </div>
              <CardTitle className="font-display text-2xl">Donate</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <p className="text-muted-foreground">
                Your contribution directly supports our programs and helps us expand our reach to more communities.
              </p>
              <Button 
                variant="cta" 
                className="w-full" 
                onClick={() => setShowQrDialog(true)}
              >
                Donate Now
              </Button>
            </CardContent>
          </Card>
        </div>

        <div className="mt-12 text-center">
          <Card className="max-w-2xl mx-auto shadow-card border-primary/20 bg-gradient-to-br from-primary/5 to-secondary/5">
            <CardContent className="p-8">
              <p className="text-lg text-foreground font-semibold mb-4">
                Every contribution makes a difference
              </p>
              <p className="text-muted-foreground">
                Whether you volunteer your time, partner with us, or make a financial contribution, you're helping us create lasting positive change in our communities.
              </p>
            </CardContent>
          </Card>
        </div>
      </div>

      {/* QR Code Dialog */}
      <Dialog open={showQrDialog} onOpenChange={setShowQrDialog}>
        <DialogContent className="sm:max-w-md">
          <DialogHeader>
            <DialogTitle className="font-display text-2xl">Donate via PhonePe</DialogTitle>
            <DialogDescription>
              Scan the QR code below using your PhonePe app to make a donation
            </DialogDescription>
          </DialogHeader>
          <div className="flex justify-center p-6">
            <img 
              src={qrCode} 
              alt="PhonePe QR Code for Kaosar Ahmed Choudhury" 
              className="w-full max-w-sm rounded-lg shadow-card"
            />
          </div>
        </DialogContent>
      </Dialog>
    </section>
  );
};
