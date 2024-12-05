require 'openai'

class GenerateAiController < ApplicationController
  def create
    # フォームデータの取得
    @generate_ai_form = GenerateAiForm.new(generate_ai_params)

    # バリデーションチェック
    if @generate_ai_form.valid?
      # OpenAI APIを利用した言葉の生成処理
      generated_text = call_openai_api(@generate_ai_form)

      # 成功時のレスポンス（例: JSONで返す場合）
      render json: { generated_text: }, status: :ok
    else
      # バリデーションエラー時のレスポンス
      render json: { errors: @generate_ai_form.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def check_ai_usage
    # クラスメソッドで判定
    if OpenAiDay.can_use_api?(current_user)
      render json: { success: true }, status: :ok
    else
      render json: { success: false, message: 'API呼び出しは1日5回までです。' }, status: :ok
    end
  end

  private

  # フォームから送信されたパラメータを許可
  def generate_ai_params
    params.require(:generate_ai_form).permit(:recipient, :message, :tone)
  end

  # OpenAI APIの呼び出し処理
  def call_openai_api(form_data)
    client = OpenAI::Client.new(access_token: ENV.fetch('OPENAI_API_KEY', nil))
    # プロンプトを生成
    prompt = "#{form_data.recipient}に対する#{form_data.tone}な言葉で、#{form_data.message}に関連したツンデレ風の言葉を生成してください。"

    response = client.chat(
      parameters: {
        model: 'gpt-3.5-turbo',
        messages: [
          { role: 'system', content: 'あなたはツンデレ言葉で回答してください' },
          { role: 'user', content: prompt }
        ],
        temperature: 0.7
      }
    )

    # レスポンスから生成されたテキストを取得
    response.dig('choices', 0, 'message', 'content')
  rescue StandardError => e
    Rails.logger.error "OpenAI APIリクエスト中にエラーが発生しました: #{e.message}"
    'エラーが発生しました。再試行してください。'
  end
end
