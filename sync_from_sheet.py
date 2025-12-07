import os
import json
import re
from pathlib import Path

import gspread
from google.oauth2.service_account import Credentials


def slugify(text: str) -> str:
    text = text.strip().lower()
    # replace non-alphanumeric with underscore
    text = re.sub(r"[^a-z0-9]+", "_", text)
    # remove leading/trailing underscores
    text = text.strip("_")
    return text or "untitled"


def main():
    sheet_id = os.environ["SHEET_ID"]
    creds_info = json.loads(os.environ["GOOGLE_CREDENTIALS"])

    scopes = ["https://www.googleapis.com/auth/spreadsheets.readonly"]
    creds = Credentials.from_service_account_info(creds_info, scopes=scopes)
    gc = gspread.authorize(creds)

    # Open sheet & first worksheet
    sh = gc.open_by_key(sheet_id)
    ws = sh.sheet1

    # Read all rows as dicts using header row
    rows = ws.get_all_records()

    base_dir = Path("sql")
    base_dir.mkdir(exist_ok=True)

    changed_files = []

    for row in rows:
        title = row.get("Title") or row.get("title")
        folder = row.get("Folder") or row.get("folder")
        code = row.get("Code") or row.get("code")

        # Skip incomplete rows
        if not title or not folder or not code:
            continue

        folder_slug = slugify(folder)
        file_slug = slugify(title) + ".sql"

        topic_dir = base_dir / folder_slug
        topic_dir.mkdir(parents=True, exist_ok=True)

        file_path = topic_dir / file_slug

        # Only write if content changed
        if file_path.exists():
            old = file_path.read_text(encoding="utf-8")
            if old == code:
                continue

        file_path.write_text(code, encoding="utf-8")
        changed_files.append(str(file_path))

    print(f"Updated {len(changed_files)} files.")
    if changed_files:
        print("\n".join(changed_files))


if __name__ == "__main__":
    main()
