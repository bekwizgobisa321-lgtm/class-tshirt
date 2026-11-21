# CS Squad Shirt Drop: Pay the Left Money

Students open the link, write their name, upload a screenshot of the payment, and send. You see every payment in Supabase.

## Folder

```
index.html            the page
config.js             Supabase keys + amount / account / deadline text (you edit this)
vercel.json           Vercel settings
supabase/schema.sql   the new table + private screenshot bucket (run once)
```

## Step 1: Database (one time)

1. Open your Supabase project (the same one you already use).
2. SQL Editor, New query. Paste all of `supabase/schema.sql`. Press Run. You should see "Success".

This makes:
- table `cs_balance_payments` (name, screenshot path, status, time)
- private bucket `balance-screenshots` (images only, max 5 MB)

Visitors can only add. They cannot read or delete anything.

## Step 2: Fill the payment text

Open `config.js` and write the amount left, where to pay, and the deadline. Empty lines are hidden.

## Step 3: Test on your computer

Double-click `index.html`. Send a fake name with a screenshot. Then check:
- Table Editor, `cs_balance_payments`: you see the name.
- Storage, `balance-screenshots`: you see the image. Its file name starts with the student's name.

## Step 4: Update GitHub and Vercel

```bash
git add .
git commit -m "cs final payment page"
git push
```

Vercel updates by itself.

## Check payments

Table Editor, `cs_balance_payments`. After you check a screenshot, change `status` from `pending` to `paid`.

```sql
select full_name, screenshot_path, status, created_at
from public.cs_balance_payments
order by created_at desc;
```
