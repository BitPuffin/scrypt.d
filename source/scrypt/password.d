module scrypt.password;

/*
 * Copyright (C) 2013 Isak Andersson (BitPuffin@lavabit.com)
 * 
 * Distributed under the terms of the Zlib/libpng license
 * See LICENSE.txt in project root for more info
 */

import scrypt.scryptenc;

// TODO: Write docs
string generateRandomSalt() {
    // TODO: You'll know what to do
    return "";
}

// TODO: Write docs
string getEncodedPassword(string password, string salt) {
    // TODO: You'll know what to do
    ubyte[] outpw;
    size_t buflen = password.length + salt.length;
    return "";
}
