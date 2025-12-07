import os
import json
import re
from pathlib import Path

import gspread
from google.oauth2.service_account import Credentials


def slugify(text: str) -> str:
    text = text.strip().lower()
    text = re.sub(r"[^a-z0-9]+", "_", text)
    return text.strip("_") or "untitled"


def main():
    # Load credentials
    sheet_id = os.environ["SHEET_ID"]
    creds_info = json.loads(os.environ["GOOGLE_CREDENTIALS"])

    scopes = ["https://www.googleapis.com/auth/spreadsheets.readonly"]
    creds = Credentials.from_service_account_info(creds_info, scopes=scopes)
    gc = gspread.authorize(creds)

    # Open Sheet
    sh = gc.open_by_key(sheet_id)
    ws = sh.sheet1

    # Read all data as dict rows
    rows = ws.get_all_records()

    # Prepare folder
    base_dir = Path("sql")
    base_dir.mkdir(exist_ok=True)

    # Extract header to detect topic columns
    header = ws.row_values(1)

    # Identify topic columns: everything after "Code"
    topic_columns = header[2:]  # Title = col1, Code = col2, topics from col3+

    changed_files = []

    for row in rows:
        title = row.get("Title") or row.get("title")
        code = row.get("Code") or row.get("code")

        # Skip incomplete rows
        if not title or not code:
            continue

        filename = slugify(title) + ".sql"

        # Process topic columns
        for topic in topic_columns:
            raw_val = str(row.get(topic, "")).strip().lower()

            if raw_val in ("true", "1", "yes"):
                folder = slugify(topic)
                topic_dir = base_dir / folder
                topic_dir.mkdir(parents=True, exist_ok=True)

                file_path = topic_dir / filename

                # Only write if changed
                if file_path.exists():
                    old_content = file_path.read_text(encoding="utf-8")
                    if old_content == code:
                        continue

                file_path.write_text(code, encoding="utf-8")
                changed_files.append(str(file_path))

    print(f"Updated {len(changed_files)} files.")
    if changed_files:
        print("\n".join(changed_files))


if __name__ == "__main__":
    main()
