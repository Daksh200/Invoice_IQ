# 🧾 Invoice_IQ — AI-Powered Accounting App

> **Your personal AI accountant.** Upload photos of receipts, invoices, or PDFs, and Invoice_IQ automatically extracts, categorizes, and stores all the important data into a structured database.

Invoice_IQ is a self-hosted, AI-powered accounting application designed for freelancers, indie-hackers, and small businesses who want to save time and automate expense and income tracking using the power of modern AI (LLMs).

---

## 📑 Table of Contents

- [✨ Features](#-features)
- [🧠 Supported AI Providers](#-supported-ai-providers)
- [🏗️ Tech Stack](#-tech-stack)
- [📋 Requirements](#-requirements)
- [🚀 Quick Start (Local Development)](#-quick-start-local-development)
- [🗺️ Deployment Guide (Step by Step)](#️-deployment-guide-step-by-step)
  - [Option A: Deploy on Render (Free) with Supabase](#option-a-deploy-on-render-free-with-supabase)
  - [Option B: Self-Host with Docker Compose](#option-b-self-host-with-docker-compose)
- [🔐 Environment Variables Reference](#-environment-variables-reference)
- [🔒 Security Best Practices](#-security-best-practices)
- [🎯 Creating Your Admin Account](#-creating-your-admin-account)
- [🆓 Sharing Your App with Others](#-sharing-your-app-with-others)
- [📝 Frequently Asked Questions (FAQ)](#-frequently-asked-questions-faq)
- [❓ Troubleshooting](#-troubleshooting)

---

## ✨ Features

### 1️⃣ Analyze Photos and Invoices with AI 📸

Snap a photo of any receipt or upload an invoice PDF, and Invoice_IQ will automatically recognize, extract, categorize, and store all the information in a structured database.

- **Upload and organize your docs**: Store multiple documents in "unsorted" until you're ready to process them manually or with AI assistance
- **AI data extraction**: Automatically pull key information like dates, amounts, vendors, and line items
- **Auto-categorization**: Transactions are automatically sorted into relevant categories based on their content
- **Item splitting**: Extract individual items from invoices and split them into separate transactions when needed
- **Structured storage**: Everything gets saved in an organized database for easy filtering and retrieval

### 2️⃣ Multi-Currency Support with Automatic Conversion 💱

Invoice_IQ automatically detects currencies in your documents and converts them to your base currency using historical exchange rates.

- **Foreign currency detection**: Automatically identify the currency used in any document
- **Historical rates**: Get conversion rates from the actual transaction date
- **All-world coverage**: Support for 170+ world currencies and 14 popular cryptocurrencies (BTC, ETH, LTC, DOT, and more)
- **Flexible input**: Manual entry is always available when you need more control

### 3️⃣ Use Your Own LLM 🤖

Invoice_IQ supports multiple AI providers, including local LLMs via OpenAI-compatible API endpoints (Ollama, LM Studio, vLLM, LocalAI, etc.).

### 4️⃣ Fully Customizable Categories, Projects, and Fields 🗂️

Adapt Invoice_IQ to your unique needs with unlimited customization.

- **Custom categories and projects**: Create your own groupings for transactions
- **Custom fields**: Create unlimited custom fields to extract more information (like extra columns in Excel)
- **Full-text search**: Search through the actual content of recognized documents
- **Advanced filtering**: Filter by date ranges, categories, projects, amounts, and custom fields
- **AI-powered extraction**: Write your own prompts to extract any custom information
- **Bulk operations**: Process multiple documents or transactions at once

### 5️⃣ Customize Any LLM Prompt ✍️

Take full control of how the AI processes your documents with custom prompts for fields, categories, and projects.

### 6️⃣ Flexible Data Export 📤

- **Advanced filtering**: Search and filter everything
- **Flexible exports**: Export filtered transactions to CSV with attached documents
- **Tax-ready reports**: Generate comprehensive reports for your accountant or tax advisor
- **Data portability**: Download complete data archives — your data stays yours

### 7️⃣ Self-Hosted Mode for Data Privacy 🔐

Keep complete control over your financial data with local storage and self-hosting options.

---

## 🧠 Supported AI Providers

| Provider | API Key Location | Default Model | Free Tier? |
|----------|-----------------|---------------|------------|
| **OpenAI** | `https://platform.openai.com/settings/organization/api-keys` | `gpt-4o-mini` | No (requires balance) |
| **Google Gemini** | `https://aistudio.google.com/apikey` | `gemini-2.5-flash` | ✅ Yes |
| **Mistral** | `https://admin.mistral.ai/organization/api-keys` | `mistral-medium-latest` | Yes (limited) |

> 💡 **Tip:** You only need **ONE** of these AI providers to make the app work. Google Gemini's free tier is often the easiest to start with.

You can also use **any OpenAI-compatible endpoint** (Ollama, LM Studio, vLLM, LocalAI, z.ai, etc.) by configuring a base URL.

---

## 🏗️ Tech Stack

- **Frontend & API**: Next.js 15+ (React 19)
- **Database**: PostgreSQL 17+ (via Prisma ORM)
- **AI/LLM**: LangChain (OpenAI, Google GenAI, Mistral)
- **Authentication**: Better Auth (email OTP + JWT sessions)
- **Payments**: Stripe (optional, for subscriptions)
- **Email**: Resend (optional, for OTP emails)
- **File Processing**: Ghostscript + GraphicsMagick (PDF/image processing)
- **PDF Generation**: @react-pdf/renderer and pdf2pic
- **Styling**: Tailwind CSS 4 + Radix UI
- **Currency Conversion**: Historical exchange rates + crypto support

---

## 📋 Requirements

### For Local Development
- **Node.js** >= 26
- **PostgreSQL** 17+ (locally installed or via Docker)
- **Ghostscript** and **GraphicsMagick**
  - macOS: `brew install gs graphicsmagick`
  - Linux: `sudo apt install ghostscript graphicsmagick`
  - Windows: install from official websites

### For Deployment (any host)
- Git
- Docker (for Docker deployment)
- An AI provider API key (OpenAI / Google / Mistral)

---

## 🚀 Quick Start (Local Development)

```bash
# 1. Clone the repository
git clone <your-repo-url>
cd <your-project-folder>

# 2. Install dependencies
npm install

# 3. Set up environment variables
cp .env.example .env

# 4. Edit .env
#    - Set DATABASE_URL to your PostgreSQL connection string
#    - Set at least one AI API key (OPENAI_ / GOOGLE_ / MISTRAL_)

# 5. Initialize the database
npx prisma generate && npx prisma migrate dev

# 6. Start the development server
npm run dev
```

Visit **`http://localhost:7331`** to see your local Invoice_IQ instance.

> **Note:** In self-hosted mode (`SELF_HOSTED_MODE=true`), the login screen is disabled and a default admin user (`taxhacker@localhost`) is auto-created with unlimited access.

For a production build:
```bash
npm run build
npm run start
```

---

## 🗺️ Deployment Guide (Step by Step)

Below are detailed, tested deployment paths. **Option A** (Render + Supabase) is the recommended **free** path that requires **no credit card**. **Option B** is for self-hosting on your own server with Docker.

---

### ✅ Option A: Deploy on Render (Free) with Supabase

This is the **free, no-credit-card** path. You keep the app on Render and store your database on Supabase (which never expires, unlike Render's free 30-day database).

| Piece | Where | Cost |
|-------|-------|------|
| App (Web Service) | Render | Free |
| Database (Postgres) | Supabase | Free |
| Domain + HTTPS | Render gives `*.onrender.com` | Free |

#### Step 1 — Create your accounts

1. **GitHub** (free): `https://github.com` — create an account and push/fork this project to your GitHub.
2. **Supabase** (free): `https://supabase.com`
3. **Render** (free): `https://render.com`

**No credit card is required** for any of these free tiers.

---

#### Step 2 — Create the Supabase database

1. Log in to **Supabase**.
2. Click **"New project"**.
3. Fill in:
   - **Name:** `invoiceiq` (or any name)
   - **Database Password:** create a strong one and **save it** — you'll need it! *(e.g., `MCuFGzHd4nn5L8tJ`)*
   - **Region:** pick the closest to you (e.g., `ap-northeast-1` / Tokyo, or `ap-southeast-1` / Singapore)
   - **Plan:** **Free**
4. Click **"Create new project"** and wait ~2 minutes for it to provision.

5. **Get the connection string (Transaction Pooler):**
   - On the project dashboard, click the **"Connect"** button at the **top-right** of the page.
   - Choose **"App"** → **"Transaction pooler"** (or **"Session pooler"**) tab.
   - Copy the string. It looks like:
     ```
     postgresql://postgres.yourprojectref:[YOUR-PASSWORD]@aws-0-{region}.pooler.supabase.com:6543/postgres
     ```
   - ⚠️ **Important:** Use the **pooler** string (host ends in `pooler.supabase.com`, port `6543`). The **"Direct connection"** (port `5432`, host `db....supabase.co`) often only works over IPv6, which Render's free tier does **not** support — using it causes "PostgreSQL server is unavailable".

---

#### Step 3 — Deploy the app on Render

1. Log in to **Render**.
2. Click **"New +"** → **"Web Service"**.
3. **Connect your GitHub repo** that contains the Invoice_IQ/TaxHacker code.
4. Configure the service:
   - **Name:** `invoiceiq`
   - **Runtime:** Docker (Render auto-detects the `Dockerfile`)
   - **Branch:** `main`
   - **Region:** any (close to your users)
   - **Plan:** **Free**

5. **Set up Environment Variables** (`Environment` tab → Add):

   | Key | Value |
   |-----|-------|
   | `NODE_ENV` | `production` |
   | `PORT` | `7331` |
   | `SELF_HOSTED_MODE` | `false` (for a login screen) **or** `true` (no login) |
   | `DISABLE_SIGNUP` | `true` (only you create accounts) or `false` (open registration) |
   | `BASE_URL` | `https://invoiceiq.onrender.com` (your actual Render URL) |
   | `UPLOAD_PATH` | `/app/data/uploads` |
   | `DATABASE_URL` | Your **Supabase Transaction Pooler** string with password + `?sslmode=require` (see below) |
   | `BETTER_AUTH_SECRET` | A long random string (min 16 chars) |
   | `OPENAI_API_KEY` | *(optional)* your OpenAI key, ends `sk-...` |
   | `OPENAI_MODEL_NAME` | `gpt-4o-mini` (optional) |
   | `GOOGLE_API_KEY` | *(optional)* your Gemini key |
   | `GOOGLE_MODEL_NAME` | `gemini-2.5-flash` (optional) |
   | `MISTRAL_API_KEY` | *(optional)* your Mistral key |
   | `MISTRAL_MODEL_NAME` | `mistral-medium-latest` (optional) |

   **Your `DATABASE_URL`** should be exactly the pooler string with your password filled in, ending with `?sslmode=require`:
   ```
   postgresql://postgres.yourprojectref:YOUR_DB_PASSWORD@aws-0-ap-northeast-1.pooler.supabase.com:6543/postgres?sslmode=require
   ```

6. **Save Changes** → Render will build and deploy the Docker image (takes ~10–15 minutes the first time).

7. **Under `Settings` → `Deploy` → `Docker Command` (optional):** if the app starts but Render reports "No open ports detected", set it to:
   ```
   next start -p $PORT
   ```

---

#### Step 4 — Verify the deployment

1. Wait until Render shows a green checkmark (deploy succeeded).
2. Open your site: `https://invoiceiq.onrender.com`
3. You should see the Invoice_IQ landing page or login screen.

> ✅ **Success check:** In Render's **Logs**, you should see:
> - `PostgreSQL server is ready!`
> - `Running database migrations...`
> - `prisma:query SELECT ...` (the app is querying the database)
> - A `Ready` / `Local:` line showing the web server is listening

---

#### Step 5 — Create your admin account

If you set `SELF_HOSTED_MODE=false` and `DISABLE_SIGNUP=true`, you need to create your first account directly in the database.

**Use Supabase's SQL Editor** (no psql installation needed!):

1. Go to **Supabase** → your project → **SQL Editor** (left sidebar) → **New query**.
2. Create your admin user (replace `you@example.com` with your email):
   ```sql
   INSERT INTO users (id, email, name, membership_plan, is_email_verified, updated_at)
   VALUES (
     '6f5b4f8e-6f7a-4c3d-9b8b-7f2d2d61a9c3',
     'you@example.com',
     'Owner',
     'unlimited',
     true,
     now()
   );
   ```
3. Run it (click **"Run"**).

> 💡 **Much easier alternative:** Set `DISABLE_SIGNUP=false` temporarily, register through the website (with a working email), then set it back to `true`. This creates your account automatically. *(Requires `RESEND_API_KEY` for OTP emails — see FAQ.)*

---

#### Step 6 — Share your app 🎉

Once it's running, share your public URL:
```
https://invoiceiq.onrender.com
```

- If `DISABLE_SIGNUP=true`: only accounts you create can log in.
- If `DISABLE_SIGNUP=false`: anyone can register and use it.

---

### ✅ Option B: Self-Host with Docker Compose

For full data privacy, run Invoice_IQ on your own server.

```bash
# 1. Download the compose file
curl -O https://raw.githubusercontent.com/vas3k/TaxHacker/main/docker-compose.yml

# 2. Create your .env (see the Environment Variables section)
cp .env.example .env
nano .env

# 3. Start everything
docker compose up -d
```

The bundled setup includes:
- Invoice_IQ application container
- PostgreSQL 17+ database
- Automatic database migrations on startup
- Persistent data volumes (`./data`, `./pgdata`)
- Production-ready security settings

Your app is available at `http://localhost:7331`.

For a custom build of your own code:
```bash
docker compose -f docker-compose.build.yml up -d --build
```

> ⚠️ **To expose publicly**, put a reverse proxy (Caddy or nginx + Let's Encrypt) in front, set `BASE_URL` to your domain, and consider Cloudflare Access for authentication. **Never expose self-hosted mode (`SELF_HOSTED_MODE=true`) to the public internet** without extra protection, because it disables login.

---

## 🔐 Environment Variables Reference

| Variable | Required | Description | Example |
|----------|----------|-------------|---------|
| `PORT` | No | Port the app runs on | `7331` |
| `BASE_URL` | Yes (prod) | Public base URL | `https://invoiceiq.onrender.com` |
| `SELF_HOSTED_MODE` | No | `true` = disabled login; `false` = login enabled | `false` |
| `DISABLE_SIGNUP` | No | `true` = block new registrations | `false` |
| `UPLOAD_PATH` | Yes | Directory for uploads | `./data/uploads` |
| `DATABASE_URL` | Yes | PostgreSQL connection string | `postgresql://...` |
| `POSTGRES_USER` | No | DB user (Docker) | `postgres` |
| `POSTGRES_PASSWORD` | Yes (build) | DB password (Docker) | strong random |
| `POSTGRES_DB` | No | Database name (Docker) | `taxhacker` |
| `BETTER_AUTH_SECRET` | Recommended | Auth encryption secret (min 16 chars) | long random string |
| `OPENAI_API_KEY` | One AI key needed | OpenAI API key | `sk-...` |
| `OPENAI_MODEL_NAME` | No | OpenAI model | `gpt-4o-mini` |
| `GOOGLE_API_KEY` | One AI key needed | Google Gemini key | `...` |
| `GOOGLE_MODEL_NAME` | No | Gemini model | `gemini-2.5-flash` |
| `MISTRAL_API_KEY` | One AI key needed | Mistral key | `...` |
| `MISTRAL_MODEL_NAME` | No | Mistral model | `mistral-medium-latest` |
| `STRIPE_SECRET_KEY` | No | Stripe payments | `sk_live_...` |
| `STRIPE_WEBHOOK_SECRET` | No | Stripe webhook | `whsec_...` |
| `RESEND_API_KEY` | No | Email service | `re_...` |
| `RESEND_AUDIENCE_ID` | No | Newsletter audience | `aud_...` |
| `RESEND_FROM_EMAIL` | No | Sender email | `TaxHacker <you@email.com>` |

> ⚠️ **Matching passwords:** The `POSTGRES_PASSWORD` and the password inside `DATABASE_URL` must match, or the app can't connect to the database.

---

## 🔒 Security Best Practices

1. **Never expose `SELF_HOSTED_MODE=true` to the internet** — it disables login. Use it only on a trusted private network or behind a reverse proxy with its own authentication.
2. **Use a strong `BETTER_AUTH_SECRET`** (min 16 chars) — it encrypts auth tokens and email credentials.
3. **Use a strong `POSTGRES_PASSWORD`** and keep your database private (not exposed publicly).
4. **Always use HTTPS** (Render/Caddy/Fly provide free automatic certificates).
5. **Rotate secrets if exposed:** If you paste API keys in a chat/code review, regenerate them at the provider dashboard immediately.
6. **Back up your data regularly:** back up `./data` (uploads) and your database.

---

## 🎯 Creating Your Admin Account

### Method 1: Via SQL Editor (recommended for controlled signups)
Create the user directly in the database with a normalized email.

### Method 2: Temporarily enable signup
1. Set `DISABLE_SIGNUP=false` in Render, save & redeploy.
2. Register through the website with your email.
3. Set `DISABLE_SIGNUP=true` again and redeploy.

> ⚠️ This requires a working **OTP email** (via `RESEND_API_KEY`). If Resend isn't set up, the verification email won't send — use Method 1 instead.

---

## 🆓 Sharing Your App with Others

To let others use your deployed app:

- **Open registration:** Set `DISABLE_SIGNUP=false`. Anyone can register and use the app. *(Requires Resend for OTP emails.)*
- **Controlled access (cloud mode):** Keep `DISABLE_SIGNUP=true`, set `SELF_HOSTED_MODE=false`, and create accounts yourself. Note: this typically requires a **paid** subscription plan to use features (free plans may hit a Stripe/payment screen).
- **Trusted demo (self-hosted mode):** Set `SELF_HOSTED_MODE=true` — single shared workspace, no login. **Only** share with people you trust, since anyone with the URL can access it.

---

## 📝 Frequently Asked Questions (FAQ)

### Q: The app asks for Stripe/payment — how do I avoid paying?
You're in **cloud mode** (`SELF_HOSTED_MODE=false`), which requires a paid subscription. Switch to **self-hosted mode** (`SELF_HOSTED_MODE=true`) for a free unlimited plan. This disables login though.

### Q: I see "PostgreSQL server is unavailable" on Render.
You're likely using Supabase's **Direct connection** (port 5432), which is IPv6-only. Use the **Transaction pooler** string (host `pooler.supabase.com`, port `6543`) with `?sslmode=require`.

### Q: I see "No open ports detected" on Render.
The `PORT` env var doesn't match the app's port. Set `PORT=7331` in Render's Environment tab, and/or set the Docker Command to `next start -p $PORT`.

### Q: How do OTP login emails work?
OTP codes are sent via **Resend** (`RESEND_API_KEY`). Without it, emails won't send. You can fetch OTPs from the DB (`SELECT value FROM verification ORDER BY created_at DESC LIMIT 1;`) as a fallback.

### Q: Render's free database expires after 30 days — what do I do?
Don't use Render's free Postgres for a permanent app. Use a **never-expiring** free database like **Supabase** or **Neon**, and point your `DATABASE_URL` there — exactly as shown in Option A.

### Q: Can I use a local LLM?
Yes — configure an OpenAI-compatible base URL (e.g., Ollama at `http://localhost:11434/v1`). Quality depends on your model's OCR abilities.

---

## ❓ Troubleshooting

| Problem | Solution |
|---------|----------|
| **Build succeeds but app "Timed Out"** | Check value of `PORT` (set `7331`) and Docker Command. |
| **"No open ports detected"** | Set `PORT=7331` env var; set Docker Command to `next start -p $PORT`. |
| **DB connection fails** | Use the Supabase/Neon pooler URL over IPv4, add `?sslmode=require`. |
| **Migrations hang** | The entrypoint already runs migrations; override Start Command to skip duplicates. |
| **AI doesn't analyze** | Ensure at least one API key (`OPENAI_`/`GOOGLE_`/`MISTRAL_`) is set and valid. |
| **OTP email not received** | Set `RESEND_API_KEY`; or fetch OTP directly from the DB. |
| **App shows Stripe/paywall** | Switch to `SELF_HOSTED_MODE=true` for a free unlimited plan. |
| **Images not loading** | Next.js images are set to unoptimized in this project; ensure uploads path is writable/persisted. |
</content>

