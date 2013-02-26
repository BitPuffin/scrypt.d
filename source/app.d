import std.stdio;
import scrypt.password;

void main() {
    auto pw = genScryptPassword("my password", "penis");
    writeln(checkScryptPassword(pw, "my password") ? "it matched!" : "wtf");
}
