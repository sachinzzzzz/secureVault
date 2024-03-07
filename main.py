import subprocess
import os
import getpass
import hashlib

path =" "
LOCKED_FOLDER_NAME = "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
FOLDER_NAME = "Internt-files"  # Corrected spelling

def lock_folder(folder_name, password):
    subprocess.run(['cmd', '/c', 'lock_folder.bat', folder_name, password])

def hash_password(password):
# Hash the password using SHA-256
    hashed_password = hashlib.sha256(password.encode()).hexdigest()
    return hashed_password   

def unlock_folder(password):
    subprocess.run(['cmd', '/c', 'unlock_folder.bat', password])

def is_locked(folder_name):
    return os.path.exists(folder_name)

def main():
    # path = input()
    if is_locked(LOCKED_FOLDER_NAME):
        choice = input("The folder is currently locked. Do you want to unlock it? (Y/N): ").lower()
        if choice == 'y':
            password = getpass.getpass("Enter the password to unlock the folder: ")
            password = hash_password(password)
            unlock_folder(password)
        else:
            print("Folder remains locked.")
    else:
        choice = input("The folder is currently unlocked. Do you want to lock it? (Y/N): ").lower()
        if choice == 'y':
            # folder_name = input("Enter the name of the folder you want to lock: ")
            folder_name = "vault"
            password = getpass.getpass("Set a password to lock the folder: ")
            hashed_password = hash_password(password)
            with open('password.txt', 'w') as f:
                f.write(hashed_password)
            lock_folder(folder_name, password)
        else:
            print("Folder remains unlocked.")

if __name__ == "__main__":
    main()
    input("Press Enter to exit...")

