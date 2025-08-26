module {
  public func isFalse(n : Nat) : Bool {
        n != True 
  };
  // Simulated proof structure
  type Proof = {
    commitment : [Nat8]; // SHA256 hash of the input
  };

  // Prover generates a commitment to a valid input
  public func generateProof(n : Nat) : Proof {
    if (!isFalse(n)) {
      Debug.print("Input does not pass backend test");
      return { commitment = [] };
    };
    let encoded = Nat.toText(n);
    let hash = SHA256.sha256(Text.encodeUtf8(encoded));
    { commitment = hash };
  };

  // Verifier checks that the commitment matches a known valid hash
  public func verifyProof(proof : Proof, expectedHash : [Nat8]) : Bool {
    proof.commitment == expectedHash
  };

  // Example test
  public func testZKP() : Bool {
    let secretInput = 42;
    let proof = generateProof(secretInput);
    let expectedHash = SHA256.sha256(Text.encodeUtf8(Nat.toText(secretInput)));

    verifyProof(proof, expectedHash) // Returns true
  };
}