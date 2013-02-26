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


string generateRandomSalt(size_t length = 32, immutable char unique_char = SCRYPT_SALT_SEPERATOR_DEFAULT) {
    // TODO: You'll know what to do
    return "";
}

/**
  * genScryptPassword(string password, string salt, size_t outputlen, ulong N, uint r, uint p, immutable char salt_seperator
  * 
  * Some info regarding the params
  * password: The password you want to hash, for example "my password"
  * salt: The salt you want to use when hashing your password, for example generateRandomSalt();
  * outputlen: the length of the output string containing your hashed password. Reccomended value is 90.
  * N: General work factor, iteration count. Must be power of two. Recommended value for passwords: 2^14 and 2^20 for sensitive stuff
  * r: Blocksize for underlying hash. Reccommended value is 8
  * p: parallelization factor. Reccomended value is 1
  * salt_seperator: Whatever you passed to generateRandomSalt as the unique_char argument, the default is $
  * If you want to you can use SCRYPT_N_DEFAULT, SCRYPT_R_DEFAULT, SCRYPT_P_DEFAULT, SCRYPT_OUTPUTLEN_DEFAULT as default params
  */
string genScryptPassword(string password, string salt, size_t outputlen, ulong N, uint r, uint p, immutable char salt_seperator = SCRYPT_SALT_SEPERATOR_DEFAULT) {
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
