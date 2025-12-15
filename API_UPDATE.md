# TOS Dart SDK API Updates

This document tracks tos-dart-sdk version updates and any required changes in Spartan.

---

## v0.29.4 - BlockDAG Terminology Migration

### Summary

Updated tos-dart-sdk from v0.29.3 to v0.29.4. No code changes required in Spartan.

### Dependency Update
- **File**: `pubspec.yaml`
- **Change**: `tos_dart_sdk: ^0.29.3` → `tos_dart_sdk: ^0.29.4`

### Breaking Changes in tos-dart-sdk v0.29.4

This release migrates from GHOSTDAG terminology back to BlockDAG terminology:

#### RPC Method Renames
| Old Method | New Method |
|------------|------------|
| `getBlueScore()` | `getHeight()` |
| `getStableBlueScore()` | `getStableHeight()` |
| `getBlocksAtBlueScore()` | `getBlocksAtHeight()` |

#### DTO Field Renames
| DTO Class | Old Field | New Field |
|-----------|-----------|-----------|
| `Block` | `blueScore` | `height` |
| `GetInfoResult` | `blueScore` | `height` |
| `GetInfoResult` | `stableBlueScore` | `stableHeight` |
| `PeerEntry` | `blueScore` | `height` |
| `GetHardForksResult` | `blueScore` | `height` |
| `GetMinerWorkResult` | `blueScore` | `height` |
| `GetBlockTemplateResult` | `blueScore` | `height` |
| `DevFeeThresholds` | `blueScore` | `height` |

#### Class Renames
| Old Class | New Class |
|-----------|-----------|
| `GetBlocksAtBlueScoreParams` | `GetBlocksAtHeightParams` |

### Impact on Spartan

**✅ No code changes required**

Spartan does not directly use the renamed fields (`blueScore`) or methods (`getBlueScore`, etc.). The SDK update is a dependency-only change.

### Verification

```bash
flutter analyze lib --no-fatal-infos
```
**Result**: ✅ No new errors (14 pre-existing warnings/infos unrelated to this update)

---

## v0.29.3 - API Simplification

### Summary

Updated tos-dart-sdk from v0.29.2 to v0.29.3 and adapted code to handle API changes.

### Changes Made

#### 1. Dependency Update
- **File**: `pubspec.yaml`
- **Change**: tos-dart-sdk updated to 0.29.3

#### 2. API Compatibility Fixes

#### File: `lib/features/wallet/application/node_info_provider.dart`

**Issue**: In v0.29.3, several `GetInfoResult` fields became optional (nullable):
- `circulatingSupply: int?`
- `burnedSupply: int?`
- `averageBlockTime: int?`
- `blockReward: int?`

**Fix**: Added null-coalescing operators (`??`) with default values of `0`:

```dart
// Before (v0.29.2)
circulatingSupply: formatTos(info.circulatingSupply, walletState.network),
burnSupply: formatTos(info.burnedSupply, walletState.network),
averageBlockTime: Duration(milliseconds: info.averageBlockTime),
blockReward: formatTos(info.blockReward, walletState.network),

// After (v0.29.3)
circulatingSupply: formatTos(info.circulatingSupply ?? 0, walletState.network),
burnSupply: formatTos(info.burnedSupply ?? 0, walletState.network),
averageBlockTime: Duration(milliseconds: info.averageBlockTime ?? 0),
blockReward: formatTos(info.blockReward ?? 0, walletState.network),
```

**Lines Changed**: 23-27

## Breaking Changes in tos-dart-sdk v0.29.3

### GetInfoResult DTO
New optional fields added:
- `stableBlueScore: int?`
- `bps: int?`
- `actualBps: int?`
- `blockVersion: int?`

Existing fields made optional:
- `circulatingSupply: int?`
- `maximumSupply: int?`
- `burnedSupply: int?`
- `emittedSupply: int?`
- `blockTimeTarget: int?`
- `averageBlockTime: int?`
- `blockReward: int?`
- `minerReward: int?`
- `devReward: int?`
- `stableHeight: int?`

### Block DTO
Fields made optional:
- `cumulativeDifficulty: String?`
- `difficulty: String?`
- `extraNonce: String?`
- `miner: String?`

### API Method Renames
- `get_blocks_at_height` → `get_blocks_at_blue_score` (not used in Spartan)
- Note: This was reversed back to `get_blocks_at_height` in v0.29.4

## Verification

### Code Analysis
```bash
flutter analyze lib --no-fatal-infos
```
**Result**: ✅ No errors found (13 pre-existing warnings/infos unrelated to this update)

### Modified File Analysis
```bash
dart analyze lib/features/wallet/application/node_info_provider.dart
```
**Result**: ✅ No issues found!

## Impact Assessment

### ✅ No Impact Areas
- Block DTO optional fields (not directly accessed in Spartan code)
- `get_blocks_at_blue_score` method (not used in Spartan)
- New GetInfoResult fields (not accessed yet)

### ✅ Fixed Impact Areas
- GetInfoResult optional fields in `node_info_provider.dart`

## Testing Recommendations

1. Test wallet information display to ensure node info is shown correctly
2. Verify that supply metrics, block reward, and average block time display properly
3. Test with nodes that may return null values for optional fields

## Notes

- Default value of `0` is used for missing numeric fields
- This approach ensures backward compatibility while supporting new API changes
- No user-facing functionality is affected by these changes
