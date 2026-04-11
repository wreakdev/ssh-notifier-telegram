import subprocess, os, requests as r
from dotenv import load_dotenv
from colorama import Fore

load_dotenv()
token = os.getenv("TOKEN")
chat_id = os.getenv("CHAT_ID")
ignore_ip = os.getenv("IGNORE_IP")
rd = Fore.RED
lb = Fore.LIGHTBLACK_EX
w = Fore.WHITE
reset = Fore.RESET

def notify(text):
    url = f"https://api.telegram.org/bot{token}/sendMessage"
    payload = {
        "chat_id": chat_id,
        "text": text,
        "parse_mode": "HTML"
    }
    try:
        r.post(url, json=payload, timeout=5)
    except Exception as e:
        print(f"{lb}[{w}Error{lb}] {rd}{e}{reset}")

def monitoring():
    cmd = ["journalctl", "-u", "ssh", "-f", "-n", "0"]
    process = subprocess.Popen(cmd, stdout=subprocess.PIPE, text=True)
    failed_triggers = ["Failed password", "Connection closed by authenticating user", "Invalid user"]
    success_triggers = ["Accepted password", "Accepted publickey"]
    print(f"{lb}[{w}Info{lb}] {w}Monitoring started (All Events){reset}")
    for line in process.stdout:
        if ignore_ip and ignore_ip in line:
            continue
        clean_line = line.strip()
        # 1. Failed
        if any(trigger in line for trigger in failed_triggers):
            msg = f"⚠️ <b>Failed SSH Attempt:</b>\n<code>{clean_line}</code>"
            notify(msg)
        # 2. Success
        elif any(trigger in line for trigger in success_triggers):
            msg = f"✅ <b>Successful SSH Login:</b>\n<code>{clean_line}</code>"
            notify(msg)

if __name__ == "__main__":
    monitoring()