# GitHub 推送配置指南

## 快速配置

### 1. 在 GitHub 上创建仓库

1. 访问 https://github.com/new
2. 填写仓库名称：`dream-of-red-chamber`（或其他你喜欢的名字）
3. 选择 **Public** 或 **Private**
4. 不要勾选 "Initialize this repository with a README"（因为我们已经有文件了）
5. 点击 **Create repository**

### 2. 关联远程仓库

```bash
cd /root/.openclaw/workspace/dream-of-red-chamber
git remote add origin https://github.com/你的用户名/dream-of-red-chamber.git
```

### 3. 推送现有代码

```bash
git push -u origin master
```

## 使用 SSH（推荐）

如果你配置了 SSH 密钥：

```bash
git remote add origin git@github.com:你的用户名/dream-of-red-chamber.git
git push -u origin master
```

## 后续更新

配置完成后，每次我编写新一回合时，会自动：
1. 提交到本地 git
2. 推送到 GitHub

你可以通过以下命令手动推送：
```bash
cd /root/.openclaw/workspace/dream-of-red-chamber
git push
```

## 查看仓库状态

```bash
git status
git log --oneline -10
```
