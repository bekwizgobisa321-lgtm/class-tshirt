# Class T-Shirt Registration

Students open the link, write their name, pick a size, and save. You see every registration in Supabase.

## Folder

```
class-tshirt/
  index.html          the page
  config.js           your 2 Supabase values (you edit this)
  vercel.json         Vercel settings
  supabase/schema.sql the database (you run this once)
```

## Step 1: Make the database

1. Go to supabase.com, sign in, press **New project**. Save the database password.
2. Wait until the project is ready (1 to 2 minutes).
3. Open **SQL Editor**, then **New query**. Paste everything from `supabase/schema.sql`. Press **Run**. You should see "Success".

## Step 2: Add your keys

1. In Supabase open **Project Settings**, then **API**.
2. Copy the **Project URL** and the **anon / publishable key**.
3. Open `config.js` and replace `YOUR_PROJECT_URL` and `YOUR_ANON_KEY`.

Never use the `service_role` or secret key here.

## Step 3: Test on your computer

Double-click `index.html`. Register a fake name. Then open Supabase, **Table Editor**, `registrations`. You must see the name and size there.

Also try the same name again. You should see "This name is already on the list."

## Step 4: Deploy on Vercel

1. Put this folder on GitHub (new empty repository, then):

```bash
git init
git add .
git commit -m "class tshirt registration"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/class-tshirt.git
git push -u origin main
```

2. Go to vercel.com and sign in with GitHub.
3. Press **Add New**, then **Project**, then import `class-tshirt`.
4. Framework Preset: **Other**. Leave everything else empty. Press **Deploy**.
5. Open your link (like `class-tshirt.vercel.app`) on your phone and register once to test.
6. Send the link to your class group.

To change something later: edit the file, then `git add .`, `git commit -m "update"`, `git push`. Vercel updates by itself.

No GitHub? Drag the folder to app.netlify.com/drop and you get a link in seconds.

## See who registered

Supabase, **Table Editor**, `registrations`: every name, size and time.

Count of each size (run in SQL Editor):

```sql
select size, count(*) as total
from public.registrations
group by size
order by size;
```

Excel file: open the table, press **Export**, choose CSV.

Full list sorted by name:

```sql
select full_name, size, created_at
from public.registrations
order by full_name;
```

## Notes

- Visitors can only add names. They cannot read the list. Only you can, after logging in to Supabase.
- Free Supabase projects pause after 7 days with no activity. If it pauses, open the dashboard and press **Restore**.
- To change the shirt color in the preview, edit `--shirt` at the top of the CSS in `index.html`.
- To remove a wrong registration: Table Editor, select the row, delete it.
