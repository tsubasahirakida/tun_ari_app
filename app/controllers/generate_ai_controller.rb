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

  private

  # フォームから送信されたパラメータを許可
  def generate_ai_params
    params.require(:generate_ai_form).permit(:recipient, :message, :tone)
  end

  # OpenAI APIの呼び出し処理（ダミー実装）
  def call_openai_api(form_data)
    prompt = "#{form_data.recipient}に対する#{form_data.tone}な言葉で、#{form_data.message}に関連したツンデレ風の言葉を生成してください。"
    # ダミーの生成結果を返します
    'これは生成されたツンデレ言葉の例です'
  end
end
