using System;
using System.Linq;
using System.Security.Cryptography;

namespace tripsia.utilities
{
    public class PasswordUtilities
    {
        private const int SALT_BYTE_SIZE = 24;
        private const int HASH_BYTE_SIZE = 24;
        private const int PBKDF2_ITERATIONS = 1000;

        public string Hash(string password)
        {
            RNGCryptoServiceProvider csp = new RNGCryptoServiceProvider();
            byte[] salt = new byte[SALT_BYTE_SIZE];
            csp.GetBytes(salt);

            byte[] hash = pbkdf2Bytes(password, salt, PBKDF2_ITERATIONS, HASH_BYTE_SIZE);
            return Convert.ToBase64String(salt) + ":" + Convert.ToBase64String(hash);
        }

        public bool HashCheck(string password, string hashedPassword)
        {
            char[] delimiter = { ':' };
            string[] split = hashedPassword.Split(delimiter);
            byte[] salt = Convert.FromBase64String(split[0]);
            byte[] hash = Convert.FromBase64String(split[1]);
            byte[] testHash = pbkdf2Bytes(password, salt, PBKDF2_ITERATIONS, hash.Length);

            return hash.SequenceEqual(testHash);
        }

        private byte[] pbkdf2Bytes(string password, byte[] salt, int iterations, int outputBytes)
        {
            Rfc2898DeriveBytes pbkdf2 = new Rfc2898DeriveBytes(password, salt)
            {
                IterationCount = iterations
            };
            return pbkdf2.GetBytes(outputBytes);
        }
    }
}