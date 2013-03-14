import std.stdio;
import scrypt.password;
import std.uuid : randomUUID;

/// Just try stuff out
void main() {
    writeln("example: ", genScryptPasswordHash("password", genRandomSalt(), SCRYPT_OUTPUTLEN_DEFAULT, SCRYPT_N_DEFAULT, SCRYPT_R_DEFAULT, SCRYPT_P_DEFAULT)); 
    writeln(genScryptPasswordHash("pw", genRandomSalt(), 90, SCRYPT_N_DEFAULT, 8, 1) != genScryptPasswordHash("pw", genRandomSalt(), 90, SCRYPT_N_DEFAULT, 8, 1));

    foreach(i; 1 .. 10)
        writeln(genScryptPasswordHash("pw", genRandomSalt(), 90, SCRYPT_N_DEFAULT, 8, 1));

    foreach(i; 1 .. 5) {
        string pw = genScryptPasswordHash("very password nice really, random kind the you use should really", genRandomSalt(), 90, SCRYPT_N_DEFAULT, 8, 1);
        writeln(checkScryptPasswordHash(pw, "very password nice really, random kind the you use should really"));
    }

    // writeln("\nRunning huuuge test, stay put!\n");
    // runTest(); // Weird test
}

/// Testing stuff

/// Epic test on storing a bunch of users, not sure why I did this.
void runTest() {
    int usercount = 1000;

    writeln("Creating usernames...");

    string[] userNames;
    foreach(i; 0 .. usercount) {
        userNames ~= randomUUID().toString();
    }

    writeln("Creating passwords...");
    string[] passwords;
    foreach(i; 0 .. usercount) {
        passwords ~= randomUUID().toString();
    }

    writeln("Creating users...");
    string[string] users;
    foreach(i; 0 .. usercount) {
        users[userNames[i]] = genScryptPasswordHash(passwords[i], genRandomSalt(), SCRYPT_OUTPUTLEN_DEFAULT, SCRYPT_N_DEFAULT, SCRYPT_R_DEFAULT, SCRYPT_P_DEFAULT);
    }
    
    writeln("Verifying every damn user...");
    bool allworked = true;
    foreach(i; 0 .. usercount) {
        writeln("Testing: ", i+1);
        if (!checkScryptPasswordHash(users[userNames[i]], passwords[i])) {
            allworked = false;
            break;
        }
    }

    if (allworked) {
        writeln("Huzzaaaaahhhh!");
    } else {
        writeln("WTF??!?!?! ;______;");
    }
}
