from sys import stdout, executable
from os import name, environ, system
from importlib import import_module
from platform import system as platform_system
from time import perf_counter
from subprocess import Popen, DEVNULL
from os.path import isfile
from colorama import init, Fore, Style
from time import sleep
from socket import create_connection
from requests import get

init()

REPO = "boydev-1444/lunaux-decompiler"
BASE_URL = f"https://api.github.com/repos/{REPO}"
RAW_BASE_URL = f"https://raw.githubusercontent.com/{REPO}/main"

def supports_ansi():
    if not stdout.isatty():
        return False
    if name == "nt":
        return "ANSICON" in environ or "WT_SESSION" in environ or environ.get("TERM_PROGRAM") == "vscode"
    return True

def gradient_text(text, start_color, end_color):
    def gradient_line(line, start, end):
        result = ""
        length = max(len(line), 1)
        for i, char in enumerate(line):
            t = i / (length - 1) if length > 1 else 0
            r = int(start[0] + (end[0] - start[0]) * t)
            g = int(start[1] + (end[1] - start[1]) * t)
            b = int(start[2] + (end[2] - start[2]) * t)
            result += f"\x1b[38;2;{r};{g};{b}m{char}"
        return result + "\x1b[0m"
    
    return "\n".join(
        gradient_line(line, start_color, end_color)
        for line in text.splitlines()
    )
    
CURRENT_NUM = 0
def to_console(msg: str, color: tuple, should_numerate: bool = False):
    global CURRENT_NUM
    prefix = ""
    if should_numerate:
        CURRENT_NUM += 1
        prefix = f"[{CURRENT_NUM}] "
    else:
        prefix = " - "
    final_text = prefix + msg
    if SUPPORTS_ANSI:
        end_color = (min(color[0] + 40, 255), min(color[1] + 40, 255), min(color[2] + 40, 255))
        print(gradient_text(final_text, color, end_color))
    else:
        print(final_text)
    
SUPPORTS_ANSI = supports_ansi()
BIG_TEXT = "\n\x24\x24\x5C\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x24\x24\x5C\x20\x20\x20\x24\x24\x5C\x20\x24\x24\x5C\x20\x20\x20\x24\x24\x5C\x20\x20\x20\x20\x20\x20\x20\x20\x24\x24\x24\x24\x24\x24\x24\x5C\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x24\x24\x5C\x20\x24\x24\x5C\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x0A\x24\x24\x20\x7C\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x24\x24\x20\x7C\x20\x20\x24\x24\x20\x7C\x24\x24\x20\x7C\x20\x20\x24\x24\x20\x7C\x20\x20\x20\x20\x20\x20\x20\x24\x24\x20\x20\x5F\x5F\x24\x24\x5C\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x5C\x5F\x5F\x7C\x24\x24\x20\x7C\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x0A\x24\x24\x20\x7C\x20\x20\x20\x20\x20\x24\x24\x5C\x20\x20\x20\x24\x24\x5C\x20\x24\x24\x24\x24\x24\x24\x24\x5C\x20\x20\x20\x24\x24\x24\x24\x24\x24\x5C\x20\x20\x24\x24\x20\x7C\x20\x20\x24\x24\x20\x7C\x5C\x24\x24\x5C\x20\x24\x24\x20\x20\x7C\x20\x20\x20\x20\x20\x20\x20\x24\x24\x20\x7C\x20\x20\x24\x24\x20\x7C\x20\x24\x24\x24\x24\x24\x24\x5C\x20\x20\x20\x24\x24\x24\x24\x24\x24\x24\x5C\x20\x20\x24\x24\x24\x24\x24\x24\x5C\x20\x20\x24\x24\x24\x24\x24\x24\x5C\x24\x24\x24\x24\x5C\x20\x20\x20\x24\x24\x24\x24\x24\x24\x5C\x20\x20\x24\x24\x5C\x20\x24\x24\x20\x7C\x20\x24\x24\x24\x24\x24\x24\x5C\x20\x20\x20\x24\x24\x24\x24\x24\x24\x5C\x20\x20\x0A\x24\x24\x20\x7C\x20\x20\x20\x20\x20\x24\x24\x20\x7C\x20\x20\x24\x24\x20\x7C\x24\x24\x20\x20\x5F\x5F\x24\x24\x5C\x20\x20\x5C\x5F\x5F\x5F\x5F\x24\x24\x5C\x20\x24\x24\x20\x7C\x20\x20\x24\x24\x20\x7C\x20\x5C\x24\x24\x24\x24\x20\x20\x2F\x24\x24\x24\x24\x24\x24\x5C\x20\x24\x24\x20\x7C\x20\x20\x24\x24\x20\x7C\x24\x24\x20\x20\x5F\x5F\x24\x24\x5C\x20\x24\x24\x20\x20\x5F\x5F\x5F\x5F\x5F\x7C\x24\x24\x20\x20\x5F\x5F\x24\x24\x5C\x20\x24\x24\x20\x20\x5F\x24\x24\x20\x20\x5F\x24\x24\x5C\x20\x24\x24\x20\x20\x5F\x5F\x24\x24\x5C\x20\x24\x24\x20\x7C\x24\x24\x20\x7C\x24\x24\x20\x20\x5F\x5F\x24\x24\x5C\x20\x24\x24\x20\x20\x5F\x5F\x24\x24\x5C\x20\x0A\x24\x24\x20\x7C\x20\x20\x20\x20\x20\x24\x24\x20\x7C\x20\x20\x24\x24\x20\x7C\x24\x24\x20\x7C\x20\x20\x24\x24\x20\x7C\x20\x24\x24\x24\x24\x24\x24\x24\x20\x7C\x24\x24\x20\x7C\x20\x20\x24\x24\x20\x7C\x20\x24\x24\x20\x20\x24\x24\x3C\x20\x5C\x5F\x5F\x5F\x5F\x5F\x5F\x7C\x24\x24\x20\x7C\x20\x20\x24\x24\x20\x7C\x24\x24\x24\x24\x24\x24\x24\x24\x20\x7C\x24\x24\x20\x2F\x20\x20\x20\x20\x20\x20\x24\x24\x20\x2F\x20\x20\x24\x24\x20\x7C\x24\x24\x20\x2F\x20\x24\x24\x20\x2F\x20\x24\x24\x20\x7C\x24\x24\x20\x2F\x20\x20\x24\x24\x20\x7C\x24\x24\x20\x7C\x24\x24\x20\x7C\x24\x24\x24\x24\x24\x24\x24\x24\x20\x7C\x24\x24\x20\x7C\x20\x20\x5C\x5F\x5F\x7C\x0A\x24\x24\x20\x7C\x20\x20\x20\x20\x20\x24\x24\x20\x7C\x20\x20\x24\x24\x20\x7C\x24\x24\x20\x7C\x20\x20\x24\x24\x20\x7C\x24\x24\x20\x20\x5F\x5F\x24\x24\x20\x7C\x24\x24\x20\x7C\x20\x20\x24\x24\x20\x7C\x24\x24\x20\x20\x2F\x5C\x24\x24\x5C\x20\x20\x20\x20\x20\x20\x20\x20\x24\x24\x20\x7C\x20\x20\x24\x24\x20\x7C\x24\x24\x20\x20\x20\x5F\x5F\x5F\x5F\x7C\x24\x24\x20\x7C\x20\x20\x20\x20\x20\x20\x24\x24\x20\x7C\x20\x20\x24\x24\x20\x7C\x24\x24\x20\x7C\x20\x24\x24\x20\x7C\x20\x24\x24\x20\x7C\x24\x24\x20\x7C\x20\x20\x24\x24\x20\x7C\x24\x24\x20\x7C\x24\x24\x20\x7C\x24\x24\x20\x20\x20\x5F\x5F\x5F\x5F\x7C\x24\x24\x20\x7C\x20\x20\x20\x20\x20\x20\x0A\x24\x24\x24\x24\x24\x24\x24\x24\x5C\x5C\x24\x24\x24\x24\x24\x24\x20\x20\x7C\x24\x24\x20\x7C\x20\x20\x24\x24\x20\x7C\x5C\x24\x24\x24\x24\x24\x24\x24\x20\x7C\x5C\x24\x24\x24\x24\x24\x24\x20\x20\x7C\x24\x24\x20\x2F\x20\x20\x24\x24\x20\x7C\x20\x20\x20\x20\x20\x20\x20\x24\x24\x24\x24\x24\x24\x24\x20\x20\x7C\x5C\x24\x24\x24\x24\x24\x24\x24\x5C\x20\x5C\x24\x24\x24\x24\x24\x24\x24\x5C\x20\x5C\x24\x24\x24\x24\x24\x24\x20\x20\x7C\x24\x24\x20\x7C\x20\x24\x24\x20\x7C\x20\x24\x24\x20\x7C\x24\x24\x24\x24\x24\x24\x24\x20\x20\x7C\x24\x24\x20\x7C\x24\x24\x20\x7C\x5C\x24\x24\x24\x24\x24\x24\x24\x5C\x20\x24\x24\x20\x7C\x20\x20\x20\x20\x20\x20\x0A\x5C\x5F\x5F\x5F\x5F\x5F\x5F\x5F\x5F\x7C\x5C\x5F\x5F\x5F\x5F\x5F\x5F\x2F\x20\x5C\x5F\x5F\x7C\x20\x20\x5C\x5F\x5F\x7C\x20\x5C\x5F\x5F\x5F\x5F\x5F\x5F\x5F\x7C\x20\x5C\x5F\x5F\x5F\x5F\x5F\x5F\x2F\x20\x5C\x5F\x5F\x7C\x20\x20\x5C\x5F\x5F\x7C\x20\x20\x20\x20\x20\x20\x20\x5C\x5F\x5F\x5F\x5F\x5F\x5F\x5F\x2F\x20\x20\x5C\x5F\x5F\x5F\x5F\x5F\x5F\x5F\x7C\x20\x5C\x5F\x5F\x5F\x5F\x5F\x5F\x5F\x7C\x20\x5C\x5F\x5F\x5F\x5F\x5F\x5F\x2F\x20\x5C\x5F\x5F\x7C\x20\x5C\x5F\x5F\x7C\x20\x5C\x5F\x5F\x7C\x24\x24\x20\x20\x5F\x5F\x5F\x5F\x2F\x20\x5C\x5F\x5F\x7C\x5C\x5F\x5F\x7C\x20\x5C\x5F\x5F\x5F\x5F\x5F\x5F\x5F\x7C\x5C\x5F\x5F\x7C\x20\x20\x20\x20\x20\x20\x0A\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x24\x24\x20\x7C\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x0A\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x24\x24\x20\x7C\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x0A\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x5C\x5F\x5F\x7C\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x0A"

print(gradient_text(BIG_TEXT, (120, 70, 200), (220, 130, 200)) if SUPPORTS_ANSI else BIG_TEXT)

sleep(0.5)
to_console("Verifying internet connection...", (100, 140, 220), True)

try:
    create_connection(('1.1.1.1', 53), timeout=5)
    sleep(1)
    to_console("Internet connection verified.", (100, 200, 140))
except:
    to_console("No internet connection detected. Press any key to exit", (220, 100, 120))
    input()
    exit()
    
to_console("Analyzing OS architecture...", (100, 140, 220), True)
match platform_system().lower():
    case "windows":
        platform = "Windows"
    case "linux":
        platform = "Linux"
    case _:
        to_console(
            "[ERROR] LunaUX currently only supports Windows and Linux due to "
            "platform-specific native modules and runtime dependencies. "
            "Support for additional operating systems is planned for the near future "
            "once compatibility and stability testing is completed.\nPress any key to exit",
            (220, 100, 120)
        )
        input()
        exit()

to_console(f"OS architecture verified. ({platform})", (100, 200, 140))
sleep(0.5)
to_console("Fetching LunaUX's version...", (100, 140, 220), True)
try:
    sleep(1)
    API_URL = f"{BASE_URL}/releases/latest"
    to_console("Consulting to github's API...", (100, 140, 220), True)
    response_json = get(API_URL, timeout=5)
    if response_json.status_code != 200:
        raise Exception(f'Server responded with HTTP {response_json.status_code}')
    response_json = response_json.json()

except Exception as e:
    to_console(f"[ERROR]: Failed to fetch LunaUX's version. ({e})\nPress any key to exit", (220, 100, 120))
    input()
    exit()


def find_asset(assetName):
    for asset in response_json["assets"]:
        if asset["name"] == assetName:
            return asset["browser_download_url"]
    return None

meta_url = find_asset("meta")
if meta_url is None:
    to_console("Failed to find \"meta\" in the release assets. This may be a bug, report to the developers if is possible. Press any key to exit", (220, 100, 120))
    input()
    exit()

try:
    meta_string = get(meta_url, timeout=5).text
except Exception as e:
    to_console(f"[ERROR]: Failed to fetch LunaUX's meta information. ({e})\nPress any key to exit", (220, 100, 120))
    input()
    exit()

meta_lines = meta_string.splitlines()

def find_meta(key):
    for line in meta_lines:
        if line.startswith(key + "="):
            return line[len(key) + 1:].strip()
    return None

INSTALLER_HASH = find_meta("INSTALLER_HASH")

def install_new_installer():
    to_console("Verifying assets...", (100, 140, 220), True)
    try:
        sleep(1)
        to_console("Fetching installer...", (100, 140, 220), True)
        installer_code = get(f"{RAW_BASE_URL}/installer.py", timeout=5).text
        with open("installer.py", "w", encoding="utf-8", errors="ignore") as f:
            f.write(installer_code)
            f.flush()
            f.close()
        system("cls" if platform_system().lower() == "windows" else "clear")
        to_console("Installer updated successfully. Restarting...", (100, 200, 140))
    except Exception as e:
        to_console(f"[ERROR]: Failed to fetch the new installer. ({e})\nPress any key to exit", (220, 100, 120))
        input()
        exit()

if isfile("INSTALLER"):
    with open("INSTALLER", "r") as f:
        local_hash = f.read().strip()
        if local_hash != INSTALLER_HASH:
            to_console(f"Installer is outdated, a new version will be downloaded (Version {INSTALLER_HASH}). Press any key to continue.", (220, 190, 60), True)
            input()
            install_new_installer()
            with open("INSTALLER", "w") as f:
                f.write(INSTALLER_HASH)
                f.flush()
                f.close()
            exit()
else:
    with open("INSTALLER", "w") as f:
        f.write(INSTALLER_HASH)
        f.flush()
        f.close()

def install_new_version():
    to_console("Verifying assets...", (100, 140, 220), True)
    if len(response_json["assets"]) < 2:
        to_console("No assets found in the release, this may be a bug. Press any key to exit", (220, 100, 120))
        input()
        exit()
    
    if platform == "Windows":
        url = find_asset('luna-windows.pyd')
        lastest_name = "luna-windows.pyd"
    elif platform == "Linux":
        url = find_asset('luna-linux.so')
        lastest_name = "luna-linux.so"
    else:
        url = None
        lastest_name = None
    
    if lastest_name is None:
        to_console("Stop trying to skip OS verifications, we don't support your OS at the moment.\nPress any key to exit", (220, 100, 120))
        input()
        exit()
    if url is None:
        to_console(f"Failed to find \"{lastest_name}\" in the release assets. This may be a bug, report to the developers if is possible. Press any key to exit", (220, 100, 120))
        input()
        exit()
    to_console(f"Assets verified! Download will start shortly. ({lastest_name})", (100, 200, 140), True)
    download_request = get(url, stream=True)
    download_size = int(download_request.headers.get("content-length", 0))
    downloaded = 0
    output_name = "luna" + (".pyd" if platform_system().lower() == "windows" else ".so")
    with open(output_name, "wb") as f:
        for chunk in download_request.iter_content(chunk_size=8192):
            if not chunk:
                continue

            f.write(chunk)
            downloaded += len(chunk)
            percent = int((downloaded / download_size) * 100) if download_size else 0
            filled = int((percent / 100) * 30)
            bar = "=" * filled
            empty = " " * (30 - filled)
            stdout.write(f"\r   {Style.BRIGHT}{Fore.GREEN}Downloading{Style.RESET_ALL} {lastest_name} [{bar}>{empty}] {percent}%{Style.RESET_ALL}")
            stdout.flush()

    print()
    to_console(f"Successfully installed {lastest_name}. (saved as {output_name})", (100, 200, 140))
    

if not isfile("VERSION"):
    install_new_version()
    with open("VERSION", "w") as f:
        f.write(response_json["tag_name"])
        f.flush()
        f.close()
else:
    with open("VERSION", "r") as f:
        current_version = f.read()
        if current_version != response_json["tag_name"]:
            to_console(f"A new LunaUX version is available ({response_json["tag_name"]}). Would you like to install? (Yy/Nn)", (80, 170, 255), True)
            response = input().lower()
            if response == "y" or response == "yes":
                install_new_version()
            else:
                to_console("[WARNING] You're using an outdated LunaUX version. It may contain bugs that newer version(s) no longer have.", (220, 190, 60))
        f.flush()
        f.close()

to_console("Starting local server..", (220, 190, 60), True)
DEPS = [
    "fastapi",
    "uvicorn",
    "pydantic",
    "pytz",
    "numpy",
    "re",
    "json",
    "rich"
]

if platform_system().lower() == "windows":
    from subprocess import STARTUPINFO, STARTF_USESHOWWINDOW
    startupinfo = STARTUPINFO()
    startupinfo.dwFlags |= STARTF_USESHOWWINDOW
else:
    startupinfo = None

to_console("Installing dependencies...", (100, 140, 220), True)
for dep in DEPS:
    try:
        import_module(dep)
        to_console(f"Dependency \"{dep}\" already installed.", (100, 200, 140))
    except:
        start_time = perf_counter()
        to_console(f"Installing dependency \"{dep}\"...", (100, 140, 220), True)
        try: Popen([executable, "-m", "pip", "install", dep], stdout=DEVNULL, stderr=DEVNULL, startupinfo=startupinfo)
        except:
            to_console(f"[ERROR] Failed to install dependency \"{dep}\", try to install it manually. Press any key to exit", (220, 100, 120))
            input()
            exit()
        elapsed_time = perf_counter() - start_time
        to_console(f"Succefully installed dependency \"{dep}\" in {elapsed_time:.6f} seconds", (100, 200, 140))
        sleep(0.01)

from fastapi import FastAPI, Request
from fastapi.responses import PlainTextResponse
from base64 import b64decode
from traceback import format_exc
from uvicorn import run
from json import dumps
import luna

app = FastAPI()

@app.middleware("http")
async def add_cors(request: Request, call_next):
    response = await call_next(request)
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Content-Type"
    return response

@app.get("/")
def index():
    return "Server running!"

def get_bytecode_and_filename(data: dict):
    try:
        bytecode = b64decode(data.get("bytecode", "").encode())
        filename = data.get("filename")
        if not bytecode:
            return None, None
        return bytecode, filename
    except:
        return None, None


@app.post("/disassemble", response_class=PlainTextResponse)
async def disassemble(request: Request):
    try:
        data = await request.json()

        bytecode, filename = get_bytecode_and_filename(data)
        if bytecode is None:
            return dumps({"details": "Missing bytecode"}, ensure_ascii=False), 400

        result = luna.disassemble_bytecode(bytecode, filename)
        return result

    except Exception as e:
        return dumps(
            {
                "details": str(e),
                "trace": format_exc()
            },
            ensure_ascii=False
        ), 500




@app.post("/decompile", response_class=PlainTextResponse)
async def decompile(request: Request):
    try:
        data = await request.json()

        bytecode, filename = get_bytecode_and_filename(data)
        if bytecode is None:
            return dumps({"details": "Missing bytecode"}, ensure_ascii=False), 400


        options = data.get("options", {})
        if not isinstance(options, dict):
            options = {}

        result = luna.decompile_bytecode(bytecode, options, filename)
        return result

    except Exception as e:
        return dumps(
            {
                "details": str(e),
                "trace": format_exc()
            },
            ensure_ascii=False
        ), 500


from re import compile
RESET = "\x1b[0m"
BLUE = "\x1b[38;2;86;156;214m"
GREEN = "\x1b[38;2;106;153;85m"
GRAY = "\x1b[38;2;106;106;106m"
YELLOW = "\x1b[38;2;220;220;170m"
PURPLE = "\x1b[38;2;197;134;192m"
KEYWORDS = {"local","function","end","if","then","else","elseif","for","while", "do","repeat","until","return","break","in","and","or","not"}
token_spec = [
    ("COMMENT", r"--.*"),
    ("STRING", r"(['\"])(?:\\.|(?!\1).)*\1"),
    ("NUMBER", r"\b\d+(\.\d+)?\b"),
    ("IDENT", r"\b[A-Za-z_]\w*\b"),
    ("SYMBOL", r"[{}()\[\]=+/*:,<>.\\-]"),
    ("SKIP", r"[ \t]+"),
    ("NEWLINE", r"\n"),
]

token_re = compile("|".join(f"(?P<{name}>{pattern})" for name, pattern in token_spec))

# why did we keep this code here
def highlight_lua(code: str) -> str:
    result = []

    for line in code.split("\n"):
        highlighted_line = []
        last_end = 0

        for match in token_re.finditer(line):
            start = match.start()
            if start > last_end:
                highlighted_line.append(line[last_end:start])

            kind = match.lastgroup
            value = match.group()
            last_end = match.end()

            if kind == "COMMENT":
                highlighted_line.append(f"{GRAY}{value}{RESET}")
            elif kind == "STRING":
                highlighted_line.append(f"{GREEN}{value}{RESET}")
            elif kind == "NUMBER":
                highlighted_line.append(f"{YELLOW}{value}{RESET}")
            elif kind == "IDENT":
                if value in KEYWORDS:
                    highlighted_line.append(f"{BLUE}{value}{RESET}")
                else:
                    highlighted_line.append(value)
            else:
                highlighted_line.append(value)

        if last_end < len(line):
            highlighted_line.append(line[last_end:])

        result.append("".join(highlighted_line))

    return "\n".join(result)

from rich.console import Console
from rich.markdown import Markdown

console = Console()
changelogs = luna.get_changelogs()
md = Markdown(changelogs)
console.print(md)
print()
to_console("[SUCCESS] Server running succefully in (http://127.0.0.1:8000) 🚀", (100, 200, 140))
run(app, host="127.0.0.1", port=8000, log_level="warning", access_log=False)
