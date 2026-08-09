# 🧾 TaxHacker — Your Personal AI Accountant

> **Self-hosted accounting app crafted for freelancers, indie-hackers and small businesses.**
> Let AI scan your receipts, analyze your expenses, convert currencies, and get your taxes in order.

Built with **Next.js 16**, **React 19**, **Prisma 7**, and **PostgreSQL**. Made with ❤️ in India.

---

## ✨ Features

### 🤖 AI-Powered Document Analysis
- Upload receipts or invoices as **photos or PDFs** for automatic recognition
- Extract key information like **dates, items, and vendors**
- Works with **any language and any photo quality**
- Automatically organize everything into a **structured database**
- **Bulk upload** and analyze multiple files at once

### 💱 Multi-Currency Support
- Automatically detects foreign currencies and converts them to yours
- Knows **historical exchange rates** for the transaction date
- Supports **170+ world currencies** and popular **cryptocurrencies** (BTC, ETH, LTC, etc.)
- Manual entry always available as a fallback

### 📊 Transactions, Categories & Projects
- Fully customizable **categories, projects, and custom fields**
- Add, edit, and manage your transactions
- Filter by **any column, category, or date range**
- Customize which columns to show in the table
- **Import transactions from CSV**

### 📋 Invoice Generator
- Advanced invoice generator to create invoices in **any language**
- Edit any field, even labels and titles
- Export invoices to **PDF** or as transactions
- Save invoices as **templates** to reuse later
- Native support for **included and excluded taxes** (VAT, GST, etc.)

### 🎨 Full Control Over AI
- Expand and improve your instance with **custom LLM prompts**
- Create custom fields/categories and tell AI how to parse them
- Extract any additional information you need
- Automatically categorize by project or category
- Ask AI to assess **risk level** or any other criteria
- Bring your own keys: **OpenAI, Google Gemini, Mistral**

### 📦 Your Data — Your Rules
- **100% self-hosted** for complete privacy
- Export transactions to **CSV** for tax prep
- **Full-text search** across documents and invoices
- Download your **full data archive** at any time — we never lock your data

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| **Framework** | [Next.js 16](https://nextjs.org) (App Router) |
| **UI** | React 19, Tailwind CSS 4, Radix UI |
| **Database** | PostgreSQL with [Prisma 7](https://www.prisma.io) ORM |
| **Auth** | [Better Auth](https://www.better-auth.com) (email OTP) |
| **AI/LLM** | LangChain + OpenAI / Google Gemini / Mistral |
| **Emails** | Resend |
| **Payments** | Stripe (optional) |
| **Deployment** | Docker, Docker Compose |

---

## ⚠️ Required Environment

- **Node.js ≥ 26** (see `.nvmrc`)
- **PostgreSQL** database (local or hosted)
- **One AI provider API key** (Gemini recommended — free)

---

## 🚀 Quick Start (Local Development)

### 1. Install dependencies

```bash
npm install
```

### 2. Configure environment

Create a `.env` file in the project root:

```env
# Core
NODE_ENV=development
PORT=7331
BASE_URL=http://localhost:7331

# Database (required)
DATABASE_URL=postgresql://USER:PASSWORD@localhost:5432/taxhacker

# Auth
BETTER_AUTH_SECRET=a-very-long-random-secret-at-least-16-chars

# AI (pick at least one — Gemini is free via Google AI Studio)
GOOGLE_API_KEY=your-gemini-api-key
GOOGLE_MODEL_NAME=gemini-2.5-flash

# Emails (optional, for OTP login in cloud mode)
RESEND_API_KEY=re_your-resend-key
RESEND_FROM_EMAIL=TaxHacker <onboarding@resend.dev>
```

### 3. Run database migrations

```bash
npx prisma migrate deploy
```

### 4. Start the dev server

```bash
npm run dev
```

Open **http://localhost:7331** in your browser.

---

## 🐳 Deployment with Docker

The project includes a multi-stage `Dockerfile` and several `docker-compose` files.

### Option 1: Complete stack (app + cron + PostgreSQL)

Use `docker-compose.build.yml` to build locally:

```bash
# Set required env first
export POSTGRES_PASSWORD=your-db-password
export BETTER_AUTH_SECRET=your-long-secret

# Build and start
docker compose -f docker-compose.build.yml up -d --build
```

Migrations run automatically on startup. The app will be available at **http://localhost:7331**.

### Option 2: Use the prebuilt image

```bash
docker compose up -d
```

### Docker Compose services

| Service | Description |
|---------|-------------|
| `app` | The Next.js web application (port 7331) |
| `cron` | Background jobs (email sync, log rotation) |
| `postgres` | PostgreSQL 17 database |

> **Data persistence:** Uploads are stored in `./data` and the database in `./pgdata` — both are mounted as volumes.

---

## ☁️ Two Operating Modes

TaxHacker can run in **two modes**, controlled by the `SELF_HOSTED_MODE` env variable:

| Mode | `SELF_HOSTED_MODE` | Login for users? | Best for |
|------|--------------------|------------------|----------|
| **Self-hosted** | `true` | ❌ No login (single shared user) | Personal / private / local use |
| **Cloud** | `false` | ✅ Email-OTP signup & login | Sharing with multiple users |

### Self-hosted mode (`SELF_HOSTED_MODE=true`)
- Everyone who opens the app uses **one shared workspace** — no signup, no payment
- No email provider or Stripe needed
- Ideal for a personal instance or a trusted team on a private network

### Cloud mode (`SELF_HOSTED_MODE=false`)
- Each user signs up with their **email + OTP code**
- Requires a **Resend API key** to send OTP emails
- Optional **Stripe** for paid subscriptions
- Ideal for a public SaaS you share with others

---

## 🎯 Deploying to the Cloud (Free, No Credit Card)

For a **free, no-credit-card** deployment you can share with others, use:

| Service | Purpose | Free tier |
|---------|---------|-----------|
| **Render.com** | Web hosting (Docker) | 750 hrs/month, spins down when idle |
| **Neon / Supabase** | PostgreSQL database | 512 MB storage |
| **Resend** | OTP emails (cloud mode only) | 100 emails/day |
| **Google AI Studio** | Gemini API key (AI) | Generous free tier |

### Step-by-step on Render

1. **Push this repo to GitHub.**
2. Sign up at [render.com](https://render.com) (free, no card).
3. Create a **New → Web Service**, connect your GitHub repo.
4. Set **Environment** to `Docker`.
5. Add the environment variables from the section below.
6. Click **Create Web Service** — Render builds & deploys automatically.
7. Done! You get a free `https://your-app.onrender.com` URL with HTTPS.

### Required environment variables for Render

| Variable | Value |
|----------|-------|
| `NODE_ENV` | `production` |
| `PORT` | `7331` |
| `BASE_URL` | `https://your-app.onrender.com` (your actual URL) |
| `SELF_HOSTED_MODE` | `true` (free, no login) **or** `false` (multi-user) |
| `DATABASE_URL` | Your Neon/Supabase Postgres connection string |
| `BETTER_AUTH_SECRET` | A random string ≥ 16 chars |
| `GOOGLE_API_KEY` | Your free Gemini key |
| `GOOGLE_MODEL_NAME` | `gemini-2.5-flash` |
| `RESEND_API_KEY` | Only if cloud mode (`false`) |
| `RESEND_FROM_EMAIL` | Only if cloud mode (`false`) |

> **Important:** `BASE_URL` must match your public URL exactly (including `https://`). It's used for OTP links and redirects.

Generate a strong auth secret:
```bash
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
```

### Setting up an AI provider (free)

1. Go to [Google AI Studio](https://aistudio.google.com/apikey)
2. Sign in → **Create API key**
3. Paste it as `GOOGLE_API_KEY`

---

## 📧 Environment Variables Reference

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `BASE_URL` | ✅ | `http://localhost:7331` | Public URL of the app |
| `PORT` | | `7331` | Port the app listens on |
| `SELF_HOSTED_MODE` | | `true` | `true` = no login, `false` = cloud login |
| `DATABASE_URL` | ✅ | — | PostgreSQL connection string |
| `BETTER_AUTH_SECRET` | ✅ | — | Auth secret (≥ 16 chars) |
| `DISABLE_SIGNUP` | | `false` | Set `true` to block new signups |
| `GOOGLE_API_KEY` | | — | Gemini API key |
| `GOOGLE_MODEL_NAME` | | `gemini-2.5-flash` | Gemini model |
| `OPENAI_API_KEY` | | — | OpenAI API key |
| `OPENAI_MODEL_NAME` | | `gpt-4o-mini` | OpenAI model |
| `MISTRAL_API_KEY` | | — | Mistral API key |
| `MISTRAL_MODEL_NAME` | | `mistral-medium-latest` | Mistral model |
| `RESEND_API_KEY` | cloud only | — | Resend key for OTP emails |
| `RESEND_FROM_EMAIL` | cloud only | — | Verified sender email |
| `RESEND_AUDIENCE_ID` | | — | Resend audience for newsletters |
| `STRIPE_SECRET_KEY` | optional | — | Stripe payments |
| `STRIPE_WEBHOOK_SECRET` | optional | — | Stripe webhooks |
| `UPLOAD_PATH` | | `/data/uploads` | Where uploads are stored |

A copy-paste template with descriptions is available in **`.env.example.production`**.

---

## 🗂️ Project Structure

```
components/        # React UI components (dashboard, forms, transactions, etc.)
app/               # Next.js App Router pages & API routes
lib/               # Core logic (auth, db, config, email, files, stats)
models/            # Database models / data access layer
prisma/            # Prisma schema & migrations
ai/                # AI/LLM integration (providers, prompts, schema)
forms/             # Form validation schemas (Zod)
hooks/             # Custom React hooks
public/            # Static assets (images, fonts, landing media)
docs/              # Additional documentation
types/             # TypeScript type definitions
```

---

## 🧪 Testing & Linting

```bash
# Run the test suite (Vitest)
npm test

# Run tests in watch mode
npm run test:watch

# Lint the codebase
npm run lint
```

---

## 📖 Additional Documentation

- [`DEPLOYMENT.md`](./DEPLOYMENT.md) — Free, no-credit-card deployment guide
- [`docs/self-hosted-public-access.md`](./docs/self-hosted-public-access.md) — Exposing self-hosted instances publicly
- [`docs/migrate-0.3-0.5.md`](./docs/migrate-0.3-0.5.md) — Migrating data from older versions

---

## 🛠️ Troubleshooting

### OTP email not arriving
- Check **Resend** dashboard → Logs for delivery status.
- Emails from `onboarding@resend.dev` may land in **Spam**. Verify a domain in Resend for better delivery.

### Database connection error
- Ensure `DATABASE_URL` is correct and includes `?sslmode=require` for hosted databases like Neon.

### "Signup is disabled"
- You have `SELF_HOSTED_MODE=true` or `DISABLE_SIGNUP=true`. For open signups set both to `false`.

### Uploads fail / "file too large"
- The app allows up to **256 MB** uploads by default. Increase `bodySizeLimit` in `next.config.ts` if needed.

### "next: command not found" in Docker
- This is fixed in the current `Dockerfile` (uses the explicit binary path). Pull the latest image.

---

## 🤝 Contributing

This is an open-source project. Contributions, bug reports, and feature requests are welcome!

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📬 Contact

Made with ❤️ in India by [@Daksh](https://github.com/Daksh200)

- **Support / Contact:** [djain00009@gmail.com](mailto:djain00009@gmail.com)
- **Source Code:** [github.com/Daksh200/Invoice_IQ](https://github.com/Daksh200/Invoice_IQ)

---

## 📄 License

No license — all rights reserved. Use at your own risk.

---

## 🙏 Acknowledgements

- Built using [Next.js](https://nextjs.org), [Prisma](https://www.prisma.io), [Better Auth](https://www.better-auth.com), [LangChain](https://js.langchain.com), and [Tailwind CSS](https://tailwindcss.com)
