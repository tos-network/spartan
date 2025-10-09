# Workflow Testing Summary

## ✅ 现在你可以用 3 种方法验证 workflow

### 1️⃣ 快速语法检查（最快，无需 Docker）

```bash
./check-workflow.sh
```

- ✅ 检查 YAML 语法
- ✅ 验证 workflow 结构
- ✅ 显示 jobs 信息
- ⚡ 只需几秒钟

### 2️⃣ 使用 act 验证（需要 Docker，推荐）

```bash
# 列出所有 jobs
./test-workflow.sh list

# 验证 workflow 语法和结构
./test-workflow.sh validate

# 测试单个 job (会实际运行，很慢)
./test-workflow.sh android
./test-workflow.sh linux
```

- ✅ 完整的 workflow 验证
- ✅ 测试 job 依赖关系
- ✅ 模拟 GitHub Actions 环境
- ⚠️ 需要 Docker Desktop 运行
- ⏱️ 完整构建需要 15-30 分钟/job

### 3️⃣ 手动测试构建步骤（最可靠）

```bash
# 使用 justfile 快速测试
just init

# 或手动运行各步骤
flutter pub get
flutter_rust_bridge_codegen generate
dart run build_runner build -d
flutter build apk --release
```

- ✅ 在真实环境中测试
- ✅ 最准确的结果
- ✅ 快速反馈
- 💡 推荐在推送前运行

## 📝 推荐的工作流程

1. **编写/修改 workflow** → 保存文件

2. **快速语法检查**
   ```bash
   ./check-workflow.sh
   ```

3. **测试构建步骤**
   ```bash
   just init  # 测试代码生成
   flutter build apk --release  # 测试构建
   ```

4. **提交并推送**
   ```bash
   git add .github/workflows/release.yml
   git commit -m "Update workflow"
   git push
   ```

5. **在 GitHub 上验证** (如果需要)
   - 创建测试 tag: `git tag v0.0.0-test && git push origin v0.0.0-test`
   - 检查 Actions 页面
   - 删除测试: `git tag -d v0.0.0-test && git push origin :refs/tags/v0.0.0-test`

## 🛠️ 已安装的工具

- ✅ **act** - GitHub Actions 本地运行工具
- ✅ **yamllint** - YAML 语法检查工具
- ✅ **Docker** - 容器运行环境 (需要手动启动)

## 📚 相关文件

- `test-workflow.sh` - 主测试脚本 (需要 Docker)
- `check-workflow.sh` - 快速语法检查 (无需 Docker)
- `.actrc` - act 配置文件
- `.yamllint` - yamllint 配置文件
- `TESTING_WORKFLOWS.md` - 详细使用文档

## ⚡ 快速参考

```bash
# 最快验证
./check-workflow.sh

# 查看 workflow jobs
./test-workflow.sh list

# 完整验证（需要 Docker）
./test-workflow.sh validate

# 测试本地构建
just init
```
