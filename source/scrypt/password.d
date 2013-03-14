module scrypt.password;

/*
 * Copyright (C) 2013 Isak Andersson (BitPuffin@lavabit.com)
 * 
 * Distributed under the terms of the zlib/libpng license
 * See LICENSE.txt in project root for more info
 */

import scrypt.crypto_scrypt;
import std.string : indexOf;
import std.exception : enforce;
import std.digest.digest : toHexString;
import std.uuid : randomUUID;
import std.algorithm : splitter;
import std.array: array;
import std.conv: to;

enum SCRYPT_N_DEFAULT = 16384;
enum SCRYPT_R_DEFAULT = 8;
enum SCRYPT_P_DEFAULT = 1;
enum SCRYPT_OUTPUTLEN_DEFAULT = 90;
private enum TERMINATOR = '$'; 

/// Takes no parameters, returns a random UUID in string form
string genRandomSalt() {
    return randomUUID().toString();
}

/**
  * Some info regarding the params
  * password: The password you want to hash, for example "my password"
  * salt: The salt you want to use when hashing your password, for example generateRandomSalt();
  * scrypt_outputlen: the length of the output string containing your hashed password from scrypt. Reccomended value is 90. Note, the actual output won't be 90 since it's a sha1 digest
  * N: General work factor, iteration count. Must be power of two. Recommended value for passwords: 2^14 and 2^20 for sensitive stuff
  * r: Blocksize for underlying hash. Reccommended value is 8
  * p: parallelization factor. Reccomended value is 1
  * If you want to you can use SCRYPT_N_DEFAULT, SCRYPT_R_DEFAULT, SCRYPT_P_DEFAULT, SCRYPT_OUTPUTLEN_DEFAULT as default params
  */
string genScryptPasswordHash(string password, string salt, size_t scrypt_outputlen, ulong N, uint r, uint p) {
    ubyte[] outpw = new ubyte[scrypt_outputlen];
    crypto_scrypt(cast(ubyte*)password.ptr, password.length, cast(ubyte*)salt.ptr, salt.length, N, r, p, outpw.ptr, outpw.length);
    
    return toHexString(outpw).idup ~ TERMINATOR ~ salt ~ TERMINATOR ~ to!string(scrypt_outputlen) ~ TERMINATOR ~ to!string(N) ~ TERMINATOR ~ to!string(r) ~ TERMINATOR ~ to!string(p);
}

/**
  * Some info regarding the params
  * hash: An already hashed version of your password, for example fetched from a database
  * password: The password you wish to see if it matches
  * scrypt_outputlen: the value you used for scrypt_outputlen in genScryptPasswordHash
  * N: General work factor used in genScryptPasswordHash
  * r: Blocksize used in genScryptPasswordHash
  * p: Parallelization factor used in genScryptPasswordHash
  */
bool checkScryptPasswordHash(string hash, string password) {
    auto params = hash.splitter(TERMINATOR).array[1 .. $];
    enforce(params.length == 5, "invalid hash string, does not meet requirements");
    return genScryptPasswordHash(password, params[0], to!size_t(params[1]), to!ulong(params[2]), to!uint(params[3]), to!uint(params[4])) == hash;
}

