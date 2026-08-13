"""
(C) COPYRIGHT 2026 EXcellent TechStacks - All Rights Reserved.

Ruler Configuration and Setup Utility Written in Python.
"""

import os
import shutil
import stat
import tempfile
import urllib.request
import zipfile
from pathlib import Path

GITHUB_USER = "Bahfo"
GITHUB_REPO = "Agent-Coding-Style"
BRANCH = "main"

INSTALLATION_SCRIPT_PATH = "install-ruler.sh"


def startup():
    """Initializes and runs the ruler installation process."""
    if os.path.exists(INSTALLATION_SCRIPT_PATH):
        current_mode = os.stat(INSTALLATION_SCRIPT_PATH).st_mode
        os.chmod(INSTALLATION_SCRIPT_PATH, current_mode | stat.S_IXUSR)

    try:
        os.system("./install-ruler.sh")
        populate_ruler_folder()
    except Exception as e:
        print(f"Error while installing ruler: {e}. Exiting.")


def fetch_remote_agents(ruler_dir: Path):
    """Downloads the .agents folder from GitHub and extracts it into ~/.ruler/."""
    zip_url = f"https://github.com/{GITHUB_USER}/{GITHUB_REPO}/archive/refs/heads/{BRANCH}.zip"
    print(f"[Ruler] Fetching rule package from GitHub ({zip_url})...")

    with tempfile.TemporaryDirectory() as temp_dir:
        temp_zip = Path(temp_dir) / "repo.zip"
        extract_dir = Path(temp_dir) / "extracted"

        try:
            urllib.request.urlretrieve(zip_url, temp_zip)
            with zipfile.ZipFile(temp_zip, "r") as zip_ref:
                zip_ref.extractall(extract_dir)

            extracted_repo_root = next(extract_dir.glob("*"))
            agents_source = extracted_repo_root / ".agents"

            if agents_source.exists() and agents_source.is_dir():
                for item in agents_source.iterdir():
                    dest = ruler_dir / item.name
                    if item.is_dir():
                        shutil.copytree(item, dest, dirs_exist_ok=True)
                    else:
                        shutil.copy2(item, dest)
                print(f"Successfully copied .agents contents into {ruler_dir}")
            else:
                print(
                    "Warning: '.agents' folder not found in the GitHub repository root."
                )

        except Exception as e:
            print(f"Failed to fetch rules from GitHub: {e}")


def populate_ruler_folder():
    """Generates ~/.ruler and populates it with GitHub rules."""
    RULER_DIR = Path.home() / ".ruler"
    RULER_DIR.mkdir(parents=True, exist_ok=True)

    fetch_remote_agents(RULER_DIR)
