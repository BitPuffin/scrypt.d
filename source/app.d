import std.stdio;
import scrypt.password;

void main() {
    writeln(genScryptPassword("hej"));
    writeln("And again");
    writeln(genScryptPassword("hej"));
}
