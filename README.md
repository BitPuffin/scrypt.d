Scrypt.d
========

A library for using Scrypt encryption in the D programming language

Implemented as a DUB package (optionally buildable as a regular D library)

Features
--------

Scrypt.d comes with bindings for crypto_scrypt.h and scryptenc.h which means you can use this to either encode or decode
data/files or use it to hash data (one way).

It also comes with it's own wrapper around crypto_scrypt to make it easier to hash passwords in D, there are instructions on how to do that right below!

### Using the scrypt.password module

Because you don't wanna deal with typecasting and other bullshit, I decided to make it easy to hash your goddamned passwords.

password.d comes with 3 functions:

``` d
string genRandomSalt();
string genScryptPasswordHash(string password, string salt, size_t scrypt_outputlen, ulong N, uint r, uint p);
string checkScryptPasswordHash(string hash, string password, size_t scrypt_outputlen, ulong N, uint r, uint p);
```

Okay so password is obviously the parameter for the password you either wanna check or hash, salt is the random salt
that you want to use in the hashing process (passing genRandomSalt() should be fine), and hash is the already hashed
version of your password that you want to check against in checkScryptPasswordHash.

Now where it gets tricky is when you see the scrypt_outputlen, N, r and p parameters. What the fuck are those things?
Let me explain:

scrypt_outputlen is basically the size of the buffer that scrypt outputs to, it isn't the length of the final hash or
anything, since that's a sha1 digest of the hash prepended by the salt.

N is the General work factor. This should be a power of two. The suggested one for passwords is currently 2^14 (but if you want to use SCRYPT_N_DEFAULT, although I wouldn't trust an external library not to change that value so I'd just put my own constant in the code, do as you like, I will probably not change it ever though)
2^20 is what you should use for sensitive stuff atm e.g credit card numbers.

r is the blocksize used for the hash. Currently 8 seems to be fine (or SCRYPT_R_DEFAULT)

and p is the parallelization factor, 1 is currently a nice default. (or SCRYPT_P_DEFAULT)

All of the confusing params (scrypt_outputlen, N, r and p) *must* and I repeat __MUST__ be the same when you are calling
checkScryptPasswordHash as they were when you where calling genScryptPasswordHash, othewise they simply won't be tha same hashes.

Now here is an example of using the password module for great win:

``` d
import scrypt.password;

// Some function for saving a password in to your database for example
string password = genScryptPasswordHash(input_password_string, genRandomSalt(), SCRYPT_OUTPUTLEN_DEFAULT, SCRYPT_N_DEFAULT, SCRYPT_R_DEFAULT, SCRYPT_P_DEFAULT);
db.save("foo", password);
// end

// Some function pulling out the data from the db to check if the password matches the one you saved earlier
string password_hash = db.get("foo");
bool authenticate = checkScryptPasswordHash(password_hash, input_password, SCRYPT_OUTPUTLEN_DEFAULT, SCRYPT_N_DEFAULT, SCRYPT_R_DEFAULT, SCRYPT_P_DEFAULT);
// end
```

Simple right? Now go store passwords securely! No insecure md5 or sha1 hashes, I'll smack you down!

Dependencies
------------

+ Tarsnap (you'll need to build scrypt as a library, see "Build Instructions" below)

Build Instructions
------------------

#### POSIX instructions (this means linux, freebsd etc)

> The way I got this to run properly on my machine was to download and compile tarsnap (found at https://www.tarsnap.com/download.html)
> I then grabbed the libtarsnap.a and put it where my compiler would find it e.g (/usr/local/lib) and after that it's done as both
> scryptenc.d and crypto_scrypt.d call pragma(lib, ...) for you!

#### Windows instructions

> Someone else will have to write this as windows ain't worth my time. Should be similar to POSIX
