import argparse
from hashlib import sha256

# Define the salt value as a byte string
PASSWORD_SALT = bytes.fromhex('FE24ADC5E11E2B25288D1704ABE67A79E342ECC26064CE69C5B3177795A82264')

# Define a function to hash a given password using the salt value
def hash_password(password):
    # Combine the password and salt values, hash the result using SHA-256, and return the hex digest
    password_hash = sha256(password.encode() + PASSWORD_SALT.hex().upper().encode())
    return password_hash.hexdigest()

# Define the help menu
def print_help():
    print("Usage: python password_hash.py [-h] <password>")
    print("Generate a SHA-256 hash value for the given password.")
    print("")
    print("positional arguments:")
    print("  <password>    the password to hash")
    print("")
    print("optional arguments:")
    print("  -h, --help  show this help message and exit")
    print("")
    
# Parse command-line arguments
parser = argparse.ArgumentParser()
parser.add_argument("password", help="the password to hash", metavar="<password>")
args = parser.parse_args()

# Check for help flag
if args.password == "-h" or args.password == "--help":
    print_help()
    print("")
else:
    # Hash the password and print the result
    hashed_password = hash_password(args.password)
    print("Plaintext:Guacamole_db-Usable-Digest")
    print( args.password + ":" + hashed_password.upper())
    print("")
