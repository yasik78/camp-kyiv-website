<?php

namespace Drupal\dc2017_master\Plugin\Block;

use Drupal\Core\Block\BlockBase;

/**
 * Provides a block with pets listing.
 * @Block(
 *   id = "sponsors_block",
 *   admin_label = @Translation("Sponsors"),
 *   category = @Translation("Lists(Views) Custom")
 * )
 */
class DCSponsors extends BlockBase {
  /**
   * {@inheritdoc}
   */
  public function build() {
    $block_platinum_sponsors = [];
    $block_gold_sponsors = [];
    $block_silver_sponsors = [];
    $block_partners = [];

    if (!empty(views_get_view_result('sponsors_sidebar', 'block_1'))) {
      $block_platinum_sponsors = [
        '#type' => 'view',
        '#name' => 'sponsors_sidebar',
        '#attributes' => ['class' => ['platinum-sponsors views-row view-content'],],
        '#markup' => '<div class="title"><div class="title-platinum-sponsors"><h3>' . t('PLATINUM SPONSOR') . '</h3></div></div>',
        '#display_id' => 'block_1',

      ];
    }

    if (!empty(views_get_view_result('sponsors_sidebar', 'block_2'))) {
      $block_gold_sponsors = [
        '#type' => 'view',
        '#name' => 'sponsors_sidebar',
        '#attributes' => ['class' => ['gold-sponsors views-row view-content'],],
        '#markup' => '<div class="title"><div class="title-gold-sponsors"><h3>' . t('GOLD SPONSOR') . '</h3></div></div>',
        '#display_id' => 'block_2',
      ];
    }

    if (!empty(views_get_view_result('sponsors_sidebar', 'block_3'))) {
      $block_silver_sponsors = [
        '#type' => 'view',
        '#name' => 'sponsors_sidebar',
        '#attributes' => ['class' => ['silver-sponsors views-row view-content'],],
        '#markup' => '<div class="title"><div class="title-silver-sponsors"><h3>' . t('SILVER SPONSOR') . '</h3></div></div>',
        '#display_id' => 'block_3',
      ];
    }

    if (!empty(views_get_view_result('sponsors_sidebar', 'block_4'))) {
      $block_partners = [
        '#type' => 'view',
        '#name' => 'sponsors_sidebar',
        '#attributes' => ['class' => ['partners views-row view-content'],],
        '#markup' => '<div class="title"><div class="title-partners"><h3>' . t('PARTNER') . '</h3></div></div>',
        '#display_id' => 'block_4',
      ];
    }

    return [
      $block_platinum_sponsors,
      $block_gold_sponsors,
      $block_silver_sponsors,
      $block_partners,
    ];
  }

}
