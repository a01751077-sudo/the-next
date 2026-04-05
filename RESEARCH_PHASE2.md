# AI #9 - Research Findings: Flutter Libraries for P2P/WebRTC/Encryption

## Executive Summary

This document contains verified research on the best Flutter/Dart libraries for building P2P mesh networking applications in 2024-2026.

## 📊 Ranked Recommendations (Top 6)

| Rank | Library | Use Case |
|------|---------|----------|
| 1 | flutter_webrtc | Core WebRTC engine for cross-platform audio/video/datachannel P2P |
| 2 | peer_rtc | Higher-level mesh/topology library built on WebRTC |
| 3 | peerdart | PeerJS-style convenience wrapper for simpler peer APIs |
| 4 | cryptography | Modern, cross-platform crypto primitives for E2EE |
| 5 | pointycastle | Broad algorithm coverage (BouncyCastle port) |
| 6 | flutter_secure_storage | Platform keystore/keychain backed secure storage |

---

## 🔬 Detailed Research Findings

### 1. WebRTC & P2P Packages

#### flutter_webrtc (RECOMMENDED - Baseline)
- **Platforms:** iOS, Android, Desktop, Web
- **Features:** Audio/Video, DataChannel, Screen capture, E2EE, Insertable Streams
- **Requirements:** Android minSdkVersion 23, Java 8
- **License:** MIT
- **Note:** Requires external signaling + STUN/TURN for NAT traversal

#### peer_rtc (Mesh/Topology)
- **Platforms:** Mobile, Desktop, Web
- **Features:** MeshHub, MetaHub (gossip), StarHub topologies
- **License:** Apache-2.0
- **Best for:** Real-time games with controlled peer counts

#### peerdart (PeerJS-style)
- **Platforms:** Mobile, Web (Chrome tested)
- **Features:** Simplified peer connections, getUserMedia, call/answer
- **Dart 3 Compatible:** Yes (null-safe)

---

### 2. Local P2P (Wi-Fi Direct, BLE)

| Package | Platform | Features |
|---------|----------|----------|
| wifi_direct_plugin | Android, iOS | Wi-Fi Direct messaging, file transfer |
| flutter_p2p_connection | Android only | Wi-Fi Direct + BLE, Host/Client roles |
| flutter_p2p | Android only | Wi-Fi Direct native API |
| flutter_blue_plus | Cross-platform | GATT/Bluetooth LE |
| multicast_dns | Cross-platform | mDNS/Bonjour local discovery |

---

### 3. Cryptographic Primitives

#### cryptography (RECOMMENDED)
- **Features:** AES, ChaCha20, Ed25519, X25519, key agreement
- **Platform:** Mobile, Desktop, JS, WASM
- **Note:** Use with `cryptography_flutter` for OS crypto APIs
- **License:** Apache-2.0

#### flutter_sodium (libsodium bindings)
- **Features:** ChaCha20-Poly1305, XChaCha20-Poly1305, CryptoBox, Argon2
- **Best for:** Modern E2EE constructions

#### pointycastle
- **Features:** Wide algorithm set (AES, RSA, HMAC, digests)
- **Note:** Lower-level API, requires explicit parameter handling
- **Security:** Active maintenance, deprecated AESFastEngine

---

### 4. Secure Local Storage

#### flutter_secure_storage (RECOMMENDED - Secrets)
- **Android:** RSA wrapping + AES/GCM, optional biometric
- **iOS:** Keychain with configurable accessibility
- **Web:** LocalStorage with optional application wrapping
- **Best for:** Keys, tokens, small secrets

#### hive_ce (Encrypted Database)
- **Features:** Strong built-in encryption, no native deps
- **Platform:** Android/iOS/Desktop/Web
- **License:** Apache-2.0/BSD-3-Clause

#### drift + encrypted_drift (SQL ORM)
- **Features:** Encrypted SQLite via SQLCipher
- **Best for:** Relational encrypted databases

---

## 📋 Integration Checklist

- [ ] Add signaling channel for flutter_webrtc/peerdart/peer_rtc
- [ ] Plan STUN/TURN for Internet P2P connectivity
- [ ] Android: Set minSdkVersion 23, add network permissions
- [ ] iOS: Add NSLocalNetworkUsageDescription, NSBonjourServices
- [ ] Use flutter_secure_storage for keys/tokens
- [ ] Use hive_ce or SQLCipher for bulk encrypted data

---

## 🔧 Recommended pubspec.yaml Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # WebRTC & P2P
  flutter_webrtc: ^0.11.0
  peer_rtc: ^1.1.0
  peerdart: ^0.9.0
  
  # Encryption
  cryptography: ^2.7.0
  flutter_secure_storage: ^9.2.0
  
  # Local Storage
  hive_ce: ^2.19.0
  hive_ce_flutter: ^2.2.0
  
  # State Management
  flutter_bloc: ^8.1.0
  
  # QR Code
  qr_flutter: ^4.1.0
  
  # UI
  cupertino_icons: ^1.0.6
```

---

## ⚠️ Important Notes

1. **NAT Traversal:** WebRTC always requires signaling server + STUN/TURN for Internet connectivity
2. **Platform Limits:** Wi-Fi Direct packages are mostly Android-centric
3. **Peer Count:** Full mesh topologies scale poorly; use peer_rtc for bounded meshes
4. **Security:** Prefer modern authenticated encryption (AES-GCM, ChaCha20-Poly1305)

---

## 📚 References

- [flutter_webrtc](https://pub.dev/packages/flutter_webrtc)
- [peer_rtc](https://pub.dev/packages/peer_rtc)
- [peerdart](https://pub.dev/packages/peerdart)
- [cryptography](https://pub.dev/packages/cryptography)
- [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage)
- [hive_ce](https://pub.dev/packages/hive_ce)
- [100ms WebRTC Blog](https://100ms.live/blog/flutter-webrtc)

---

*Research completed: April 2026*
*AI #9 - Cross-Platform Development*