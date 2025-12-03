NAZMA_CHARITABLE_TRUST WEB APPLICATION

A modern, full-stack web application built with React, TypeScript, and Supabase for Nazma Social Development Trust.

**Developer:** [widgetwalker](https://github.com/widgetwalker)  
**Repository:** [nazma_charitable_trust_web](https://github.com/widgetwalker/nazma_charitable_trust_web)

---

## 🌟 Features

- **Complete Backend Infrastructure** with Supabase (PostgreSQL)
- **11 Database Tables** for programs, donations, volunteers, trustees, and more
- **Row Level Security (RLS)** for data protection
- **25+ React Query Hooks** for seamless API integration
- **TypeScript** for type safety
- **Modern UI** with shadcn/ui components
- **Responsive Design** mobile-first approach
- **Automated Features** including receipt generation, spam detection, and analytics

---

🚀 Getting Started

### Prerequisites
Make sure you have Node.js and npm installed on your machine. If not, you can install with nvm.

Installation & Development
Follow these steps to get the project running locally:

sh
# Step 1: Clone the repository
git clone <YOUR_GIT_URL>

# Step 2: Navigate to the project directory
cd <YOUR_PROJECT_NAME>

# Step 3: Install dependencies
npm i

# Step 4: Start the development server
npm run dev
The development server will start with auto-reloading and an instant preview of your changes.

## 🗄️ Backend Setup
This project uses Supabase as the backend. To set up the database:

1. Create a Supabase account at https://supabase.com
2. Create a new project
3. Follow the detailed setup instructions in [BACKEND_README.md](./BACKEND_README.md)
4. Run the database migrations in `supabase/migrations/`
5. Configure your environment variables in `.env.local`

For complete backend documentation, see:
- [Backend Overview](./BACKEND_README.md)
- [Setup Guide](./docs/supabase-setup.md)
- [API Documentation](./docs/api-documentation.md)
- [Database ERD](./docs/database-erd.md)


🛠️ Tech Stack
This project is built with modern web technologies:

Vite - Fast build tool and development server
TypeScript - Type-safe JavaScript
React - UI library
shadcn-ui - Beautiful, accessible component library
Tailwind CSS - Utility-first CSS framework
📝 Development Workflow
Local Development
Make your changes in your preferred IDE
Test locally using npm run dev
Commit your changes with descriptive commit messages
Push to your repository
Editing on GitHub
You can also edit files directly on GitHub:

Navigate to the file you want to edit
Click the "Edit" button (pencil icon)
Make your changes and commit
Using GitHub Codespaces
For a cloud-based development environment:

Navigate to your repository
Click the "Code" button (green button)
Select the "Codespaces" tab
Click "New codespace"
Edit and commit directly in the browser
🚢 Deployment
To build for production:

sh
npm run build
The optimized production build will be created in the dist directory, ready to deploy to your hosting provider of choice (Vercel, Netlify, GitHub Pages, etc.).

📦 Project Structure
.
├── src/           # Source files
├── public/        # Static assets
├── dist/          # Production build (generated)
└── package.json   # Project dependencies

---

## 👨‍💻 Author

**Developer:** widgetwalker  
**GitHub:** [@widgetwalker](https://github.com/widgetwalker)  
**Email:** widgetwalker000@gmail.com

---

## 📄 License

This project is developed for Nazma Social Development Trust.

---

## 🙏 Acknowledgments

- Nazma Social Development Trust
- Founder: Kaosar Ahmed
- Trustees: Imrana Begum, Farhana Begum

---

**Made with ❤️ by widgetwalker**
