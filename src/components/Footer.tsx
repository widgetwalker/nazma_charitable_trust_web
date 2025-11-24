import { Button } from "@/components/ui/button";

export const Footer = () => {
  const scrollToSection = (href: string) => {
    const element = document.querySelector(href);
    if (element) {
      element.scrollIntoView({ behavior: "smooth" });
    }
  };

  return (
    <footer id="legal" className="bg-foreground/5 border-t border-border">
      <div className="container mx-auto px-4 py-12">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8 mb-8">
          {/* About Section */}
          <div>
            <h3 className="font-display text-xl font-bold text-foreground mb-4">
              Nazma Trust
            </h3>
            <p className="text-muted-foreground text-sm leading-relaxed">
              Empowering communities through women's welfare, elderly support, science innovation, and social welfare initiatives.
            </p>
          </div>

          {/* Quick Links */}
          <div>
            <h3 className="font-display text-lg font-semibold text-foreground mb-4">
              Quick Links
            </h3>
            <div className="space-y-2">
              {[
                { label: "About Us", href: "#about" },
                { label: "Programs", href: "#programs" },
                { label: "Get Involved", href: "#involved" },
                { label: "Contact", href: "#contact" },
              ].map((link) => (
                <button
                  key={link.href}
                  onClick={() => scrollToSection(link.href)}
                  className="block text-sm text-muted-foreground hover:text-primary transition-smooth"
                >
                  {link.label}
                </button>
              ))}
            </div>
          </div>

          {/* Legal Info */}
          <div>
            <h3 className="font-display text-lg font-semibold text-foreground mb-4">
              Legal Information
            </h3>
            <p className="text-muted-foreground text-sm leading-relaxed mb-4">
              Registered under the Indian Trusts Act, 1882
            </p>
            <p className="text-muted-foreground text-sm leading-relaxed">
              <strong>Jurisdiction:</strong> Courts of Dimapur, Nagaland
            </p>
          </div>
        </div>

        <div className="border-t border-border pt-8">
          <div className="flex flex-col md:flex-row items-center justify-between gap-4">
            <p className="text-sm text-muted-foreground text-center md:text-left">
              © {new Date().getFullYear()} Nazma Social Development Trust. All rights reserved.
            </p>
            <div className="flex gap-4">
              <Button
                variant="ghost"
                size="sm"
                onClick={() => scrollToSection("#home")}
              >
                Back to Top
              </Button>
            </div>
          </div>

          <div className="mt-6 text-center">
            <p className="text-xs text-muted-foreground">
              Upon dissolution, all assets will be transferred to another charitable trust or government agency committed to similar objectives.
            </p>
          </div>
        </div>
      </div>
    </footer>
  );
};
