import std.stdio;
import scrypt.password;

void main() {
    writeln(getScryptPassword("hej"));
    writeln("And again");
    writeln(getScryptPassword("hej"));
}
