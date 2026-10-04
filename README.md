# A* Planner

A grade tracker for up to 10 subjects. Enter completed results and upcoming tests with their weightage, set each subject's own grade boundaries, and it tells you exactly what you need on every upcoming test to reach your target grade (A* by default), with a what-if calculator, predictions and a test calendar.

Everyone creates their own account (email + password) and sees only their own grades.

The site is three files: `index.html` (the app), `config.js` (your database connection), and `supabase/schema.sql` (database setup). It is hosted for free on GitHub Pages; accounts and data live in a free Supabase project.

---

## Setup (about 15 minutes, no coding)

### Part 1 — Database and logins (Supabase)

1. Go to <https://supabase.com> and create an account (GitHub or email sign-up both work).
2. Click **New project**. Pick any name (for example `astar-planner`), choose a strong database password (you will not need it again, but save it somewhere), choose the region closest to you (for India: **Mumbai**), and create the project. Wait a minute or two for it to finish setting up.
3. In the left sidebar open **SQL Editor** → **New query**. Open the file `supabase/schema.sql` from this repository, copy everything in it, paste it into the query box and press **Run**. It should say "Success, no rows returned".
4. In the left sidebar open **Authentication** → **Sign In / Providers** (on some layouts: **Providers**). Make sure **Email** is enabled. Then turn **Confirm email** **off** and save. (With it on, every new person has to click a link in an email before they can log in, and Supabase's free email sending is limited to a few messages per hour.)
5. Still under **Authentication**, open **URL Configuration**. You will come back here in Part 2 to paste your site address.
6. In the left sidebar open **Project Settings** → **API**. Keep this tab open; you need two values from it:
   - **Project URL** (looks like `https://abcdefghijkl.supabase.co`)
   - **anon public** key under *Project API keys* (a long string starting with `eyJ`)

### Part 2 — Hosting (GitHub)

1. Go to <https://github.com> and create an account (or sign in).
2. Click **New repository** (the **+** at the top right). Name it `astar-planner`, keep it **Public**, do not add a README, and click **Create repository**.
3. On the empty repository page click **uploading an existing file**. Drag in **all** the files from this folder: `index.html`, `config.js`, `README.md`, `.nojekyll` and the `supabase` folder. Click **Commit changes**.
4. Open `config.js` in the repository, click the pencil (**Edit this file**), and replace the two placeholder values with your Project URL and anon public key from Part 1 step 6. Keep the quotes. Click **Commit changes**.
5. Open the repository's **Settings** tab → **Pages** (left sidebar). Under *Build and deployment* set **Source** to **Deploy from a branch**, **Branch** to `main` and folder to `/ (root)`, then **Save**.
6. After a minute, reload the Pages settings page: it shows your site address, for example `https://YOUR-USERNAME.github.io/astar-planner/`.
7. Back in Supabase → **Authentication** → **URL Configuration**: set **Site URL** to that address and add it under **Redirect URLs** as well. Save. (This is what makes password-reset links come back to your site.)

### Part 3 — Use it

Open your site address, click **Create account**, and start adding subjects and tests. Share the address with anyone else; each person makes their own login.

---

## Updating the app later

Replace `index.html` in the repository with a newer version (upload it again with the same name). `config.js` and the database stay as they are.

## Changing the ten default subjects

New accounts start with ICT, English Literature, English Language, Business, International Mathematics, Hindi, Physics, Chemistry, Biology and Global Perspectives, all with A* from 90%. Each person can rename, delete or add subjects and change every boundary from inside the app. To change what new accounts start with, edit the `DEFAULT_SUBJECTS` list near the top of the script in `index.html`.

## How the calculations work

- **Percentage** = marks obtained ÷ maximum marks × 100.
- **Subject percentage** = Σ(assessment % × weightage) ÷ Σ weightage of completed assessments. A subject becomes weighted as soon as any assessment has a weightage; assessments without one are left out and flagged. With no weightages it is marks-based: total marks ÷ total maximum marks.
- **Needed on the remaining tests** = (target boundary × total weightage − Σ completed contributions) ÷ remaining weightage. That percentage, scored on every remaining test, finishes the course at the target; each test counts by its weightage. The marks shown for a test are that percentage of its maximum, rounded up to a whole mark. The next test by date is listed first. Above 100% means the target is not achievable (the best possible final percentage is shown instead); at or below 0% means it is already secured.
- **Grades** use each subject's own boundaries: the highest grade whose minimum is at or below the percentage.

## Privacy

Each account's grades are stored as one row in your Supabase project. The database rules (`supabase/schema.sql`) only allow a signed-in account to read or change its own row; nobody, including other users of the site, can see anyone else's data. The browser also keeps a local copy so the app works offline and syncs when it reconnects.

## Troubleshooting

- **"Almost ready" screen**: `config.js` still has the placeholder values, or the URL/key were pasted with a typo. Both come from Supabase → Project Settings → API.
- **"Could not reach the server"**: the Project URL in `config.js` is wrong, or the Supabase project is paused (free projects pause after a week without use; open the Supabase dashboard and click **Restore**).
- **Sign-up says to check your email, but no email arrives**: turn **Confirm email** off (Part 1 step 4), or wait an hour (free email sending is rate-limited).
- **Password reset link opens a broken page**: set the Site URL and Redirect URL (Part 2 step 7) to your exact site address.
- **Changes not appearing on another device**: the other device picks them up when its tab is next opened or focused.
