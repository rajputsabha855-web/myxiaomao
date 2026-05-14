from telegram import Update
from telegram.ext import ApplicationBuilder, MessageHandler, filters, ContextTypes
from openai import OpenAI

BOT_TOKEN = "8601771403:AAGl-VrDgsqiSVxO1zzAGYRSkxqrARRMoRk"

client = OpenAI(
    api_key="sk-5d458e48efc748a6b1f64addc251905c",
    base_url="https://api.deepseek.com"
)

async def chat(update: Update, context: ContextTypes.DEFAULT_TYPE):
    text = update.message.text

    res = client.chat.completions.create(
        model="deepseek-chat",
        messages=[
            {"role": "system", "content": "你是一个温柔、陪伴型AI助手"},
            {"role": "user", "content": text}
        ]
    )

    await update.message.reply_text(res.choices[0].message.content)

app = ApplicationBuilder().token(BOT_TOKEN).build()
app.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, chat))

app.run_polling()
