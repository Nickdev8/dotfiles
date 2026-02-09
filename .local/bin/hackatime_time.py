#!/usr/bin/env python3
import json
import os
import sys
import requests

API_BASE = "https://hackatime.hackclub.com/api/hackatime/v1"
USER_ID = os.environ.get("HACKATIME_USER_ID", "")
API_KEY = os.environ.get("HACKATIME_API_KEY", "")

def main():
    if not USER_ID or not API_KEY:
        print("--", flush=True)
        return

    url = f"{API_BASE}/users/{USER_ID}/statusbar/today"
    params = {"api_key": API_KEY}

    # Use a Session and ignore shell proxy settings that may cause hangs
    with requests.Session() as s:
        s.trust_env = False  # ignore http_proxy/https_proxy/REQUESTS_CA_BUNDLE/etc.

        try:
            # (connect timeout, read timeout) — adjust as you like
            resp = s.get(url, params=params, timeout=(5, 15))
            resp.raise_for_status()
            data = resp.json()

            # Print only the "text" (e.g., 45m)
            print(data["data"]["grand_total"]["text"], flush=True)

        except requests.exceptions.Timeout:
            print("Error: request timed out (connect<5s or read<15s).", file=sys.stderr)
            sys.exit(1)
        except requests.exceptions.RequestException as e:
            print(f"HTTP error: {e}", file=sys.stderr)
            # Optional: show server text for debugging
            if 'resp' in locals():
                try:
                    print(resp.text[:500], file=sys.stderr)
                except Exception:
                    pass
            sys.exit(1)
        except (KeyError, json.JSONDecodeError) as e:
            print(f"Bad/Unexpected JSON: {e}", file=sys.stderr)
            if 'resp' in locals():
                print(resp.text[:500], file=sys.stderr)
            sys.exit(1)

if __name__ == "__main__":
    main()
