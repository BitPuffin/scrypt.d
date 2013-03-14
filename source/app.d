import std.stdio;
import scrypt.password;

/// Just try stuff out
void main() {
    writeln("example: ", genScryptPasswordHash("password", genRandomSalt(), SCRYPT_OUTPUTLEN_DEFAULT, SCRYPT_N_DEFAULT, SCRYPT_R_DEFAULT, SCRYPT_P_DEFAULT)); 
    writeln(genScryptPasswordHash("pw", genRandomSalt(), 90, SCRYPT_N_DEFAULT, 8, 1) != genScryptPasswordHash("pw", genRandomSalt(), 90, SCRYPT_N_DEFAULT, 8, 1));

    foreach(i; 1 .. 10)
        writeln(genScryptPasswordHash("pw", genRandomSalt(), 90, SCRYPT_N_DEFAULT, 8, 1));

    foreach(i; 1 .. 50) {
        string pw = genScryptPasswordHash("very password nice really, random kind the you use should really", genRandomSalt(), 90, SCRYPT_N_DEFAULT, 8, 1);
        writeln(checkScryptPasswordHash(pw, "very password nice really, random kind the you use should really"));
    }
}
