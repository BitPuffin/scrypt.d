module scrypt.password;

/*
 * Copyright (C) 2013 Isak Andersson (BitPuffin@lavabit.com)
 * 
 * Distributed under the terms of the Zlib/libpng license
 * See LICENSE.txt in project root for more info
 */

import scrypt.crypto_scrypt;
import std.string : indexOf;
import std.exception : enforce;

enum SCRYPT_N_DEFAULT = 16384;
enum SCRYPT_R_DEFAULT = 8;
enum SCRYPT_P_DEFAULT = 1;
enum SCRYPT_OUTPUTLEN_DEFAULT = 90;
enum SCRYPT_SALT_SEPERATOR_DEFAULT = '$';

// TODO: Write docs
string generateRandomSalt() {
    // TODO: You'll know what to do
    return "";
}

// TODO: Write docs
string genScryptPassword(string password, string salt = generateRandomSalt(), size_t outputlen = SCRYPT_OUTPUTLEN_DEFAULT, ulong N = SCRYPT_N_DEFAULT, uint r = SCRYPT_R_DEFAULT, uint p = SCRYPT_P_DEFAULT, immutable char salt_seperator = SCRYPT_SALT_SEPERATOR_DEFAULT) {
    ubyte[] outpw = new ubyte[outputlen];
    crypto_scrypt(cast(ubyte*)password.ptr, password.length, cast(ubyte*)salt.ptr, salt.length, N, r, p, outpw.ptr, outpw.length);
    
    return salt ~ salt_seperator ~ cast(string)outpw.idup;
}

bool checkScryptPassword(string hash, string password, size_t outputlen = SCRYPT_OUTPUTLEN_DEFAULT, ulong N = SCRYPT_N_DEFAULT, uint r = SCRYPT_R_DEFAULT, uint p = SCRYPT_P_DEFAULT, immutable char salt_seperator = SCRYPT_SALT_SEPERATOR_DEFAULT) {
    long sep_index = indexOf(hash, salt_seperator);
    enforce(sep_index >= 0, "could not find the seperator index");
    return genScryptPassword(password, hash[0 .. sep_index], outputlen, N, r, p, salt_seperator) == hash;
}

unittest {
}
