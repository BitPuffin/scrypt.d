import std.stdio;
import scrypt.password;

void main() {
    auto pw = genScryptPassword("my password", "penis");
    writeln(checkScryptPassword("my password", pw) ? "it matched!" : "wtf");
}
