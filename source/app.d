import std.stdio;
import scrypt.password;

void main() {
    auto pw = genScryptPassword("my password", "penis");
    writeln(checkScryptPassword(pw, "my password") ? "it matched!" : "wtf");
    writeln(genScryptPassword("balls", "salt1")[0 .. 5] != genScryptPassword("balls", "salt2")[0.. 5] ? "They are different hashes!" : "wtf");
    writeln(genScryptPassword("balls", "salt1"), "\n\n");
    writeln(genScryptPassword("balls", "salt2"), "\n\n");
    writeln(genScryptPassword("balls", "salt2"), "same salt gives same shit \n\n");

    writeln("just trying params:\n", genScryptPassword("password", "", 300, 64, 16, 1, '$')); 
}
