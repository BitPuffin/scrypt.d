module scrypt.password;

/*
 * Copyright (C) 2013 Isak Andersson (BitPuffin@lavabit.com)
 * 
 * Distributed under the terms of the Zlib/libpng license
 * See LICENSE.txt in project root for more info
 */

import scrypt.crypto_scrypt;

// TODO: Write docs
string generateRandomSalt() {
    // TODO: You'll know what to do
    return "";
}

// TODO: Write docs
string genScryptPassword(string password, string salt = generateRandomSalt(), size_t outputlen = 90, ulong N = 16384, uint r = 8, uint p = 1) {
    ubyte[] outpw = new ubyte[outputlen];
    crypto_scrypt(cast(ubyte*)password.ptr, password.length, cast(ubyte*)salt.ptr, salt.length, N, r, p, outpw.ptr, outpw.length);
    
    return cast(string)outpw.idup;
}

unittest {
    static assert(genScryptPassword("foo") != genScryptPassword("foo"));
}
