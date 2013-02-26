import std.stdio;
import scrypt.password;

void main() {
    writeln("example: ", genScryptPassword("password", generateRandomSalt(), SCRYPT_OUTPUTLEN_DEFAULT, SCRYPT_N_DEFAULT, SCRYPT_R_DEFAULT, SCRYPT_P_DEFAULT, SCRYPT_SALT_SEPERATOR_DEFAULT)); 
}
