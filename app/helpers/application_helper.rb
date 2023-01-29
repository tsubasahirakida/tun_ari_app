module ApplicationHelper
  def page_title(page_title = '')
    base_title = 'ツンあり'

    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end
  def default_meta_tags
    {
      site: '~ツンあり~',
      title: 'ツンデレ感謝カードを作ろう！♡',
      reverse: true,
      charset: 'utf-8',
      description: 'このアプリでは、「愛・ツン・デレ」に溢れた感謝カードが作れるよ！気になるあの子や仲良しあの子、お世話になった人に想いを伝えよう♡！',
      keywords: 'ツンデレ,メッセージカード,ラブレター',
      canonical: request.original_url,
      separator: '|',
      noindex: ! Rails.env.production?,
      icon: [
        { href: image_url('favi.png') },
        { href: image_url('favi.png'), rel: 'apple-touch-icon', sizes: '180x180' },
      ],
      og: {
        site_name: '~ツンあり~',
        title: 'ツンデレ感謝カードを作ろう！♡',
        description: 'このアプリでは、「愛・ツン・デレ」に溢れた感謝カードが作れるよ！気になるあの子や仲良しあの子、お世話になった人に想いを伝えよう♡！',
        type: 'website',
        url: request.original_url,
        image: image_url('ツンあり.png'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        site: '@bassa_IT',
        image: image_url('ツンあり.png')
      }
    }
  end
end
