
#!/bin/bash

# Скрипт автоматического деплоя для Nexus Systems
# Этот скрипт сделает всю техническую работу за вас!

echo "🚀 NEXUS SYSTEMS - Автоматический деплой"
echo "========================================"
echo ""

# Проверяем, что мы в правильной папке
if [ ! -d "nexus-website" ]; then
    echo "❌ Ошибка: Папка nexus-website не найдена!"
    echo "Убедитесь, что вы запускаете скрипт из правильной папки."
    exit 1
fi

cd nexus-website

echo "📦 Шаг 1: Проверяем установку Git..."
if ! command -v git &> /dev/null; then
    echo "🔧 Устанавливаем Git..."
    # Для Ubuntu/Debian
    sudo apt update && sudo apt install -y git
    # Для macOS (если есть Homebrew)
    # brew install git
    # Для Windows - пользователь должен установить Git вручную
fi

echo "✅ Git готов к работе!"
echo ""

echo "📦 Шаг 2: Проверяем установку GitHub CLI..."
if ! command -v gh &> /dev/null; then
    echo "🔧 Устанавливаем GitHub CLI..."
    # Для Ubuntu/Debian
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update && sudo apt install -y gh
fi

echo "✅ GitHub CLI готов к работе!"
echo ""

echo "📦 Шаг 3: Проверяем установку Node.js..."
if ! command -v node &> /dev/null; then
    echo "🔧 Устанавливаем Node.js..."
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt-get install -y nodejs
fi

echo "✅ Node.js готов к работе!"
echo ""

echo "📦 Шаг 4: Проверяем установку Vercel CLI..."
if ! command -v vercel &> /dev/null; then
    echo "🔧 Устанавливаем Vercel CLI..."
    npm install -g vercel
fi

echo "✅ Vercel CLI готов к работе!"
echo ""

echo "🔧 Шаг 5: Настраиваем Git репозиторий..."
git init
git add .
git commit -m "🚀 Первый коммит: Nexus Systems website"

echo "✅ Локальный репозиторий создан!"
echo ""

echo "🌐 Шаг 6: Создаем репозиторий на GitHub..."
echo ""
echo "⚠️  ВАЖНО: Сейчас откроется браузер для авторизации в GitHub"
echo "   1. Войдите в свой аккаунт GitHub"
echo "   2. Разрешите доступ GitHub CLI"
echo "   3. Вернитесь в терминал и нажмите Enter"
echo ""
read -p "Нажмите Enter, когда будете готовы..."

# Авторизация в GitHub
gh auth login

# Создание репозитория
gh repo create nexus-systems-website --public --source=. --remote=origin --push

echo "✅ Репозиторий создан и код загружен на GitHub!"
echo ""

echo "🚀 Шаг 7: Деплоим на Vercel..."
echo ""
echo "⚠️  ВАЖНО: Сейчас откроется браузер для авторизации в Vercel"
echo "   1. Войдите в свой аккаунт Vercel (или создайте новый)"
echo "   2. Разрешите доступ к GitHub"
echo "   3. Вернитесь в терминал"
echo ""
read -p "Нажмите Enter, когда будете готовы..."

# Деплой на Vercel
vercel --prod

echo ""
echo "🎉 ПОЗДРАВЛЯЕМ! Ваш сайт успешно развернут!"
echo "============================================"
echo ""
echo "📋 Что было сделано:"
echo "   ✅ Создан красивый сайт для Nexus Systems"
echo "   ✅ Код загружен на GitHub"
echo "   ✅ Сайт развернут на Vercel"
echo ""
echo "🔗 Ваши ссылки:"
echo "   GitHub: https://github.com/$(gh api user --jq .login)/nexus-systems-website"
echo "   Vercel: (ссылка показана выше)"
echo ""
echo "🌐 Чтобы привязать домен nexussystems.co:"
echo "   1. Зайдите в панель Vercel"
echo "   2. Выберите ваш проект"
echo "   3. Перейдите в Settings > Domains"
echo "   4. Добавьте домен nexussystems.co"
echo "   5. Следуйте инструкциям по настройке DNS"
echo ""
echo "💡 Нужна помощь? Обратитесь к инструкции INSTRUCTIONS.md"
