<!-- ALZA last update 17. april 2020 -->
<!-- EDITED for W3 sidebar and removed active overlay  -->
<div id="mySidebar2">
    {if isset($blockcart_top) && $blockcart_top}
    <div class="w3_blockcart{if $PS_CATALOG_MODE} header_user_catalog{/if}">
      {/if}
      <div id="blockcart" class="shopping_cart">
        {include file='./includes/header.tpl'}
        {if !$PS_CATALOG_MODE}
          {include file='./includes/dropdown.tpl'}
        {/if}
      </div>
      {if isset($blockcart_top) && $blockcart_top}
    </div>
    {/if}
</div>

{counter name=active_overlay assign=active_overlay}
  {include file='./includes/popup.tpl'}

{strip}
  {addJsDef CUSTOMIZE_TEXTFIELD=$CUSTOMIZE_TEXTFIELD}
  {addJsDef img_dir=$img_dir|escape:'quotes':'UTF-8'}
  {addJsDef generated_date=$smarty.now|intval}
  {addJsDef ajax_allowed=$ajax_allowed|boolval}
  {addJsDef hasDeliveryAddress=(isset($cart->id_address_delivery) && $cart->id_address_delivery)}

  {addJsDefL name=customizationIdMessage}{l s='Customization #' mod='blockcart' js=1}{/addJsDefL}
  {addJsDefL name=removingLinkText}{l s='remove this product from my cart' mod='blockcart' js=1}{/addJsDefL}
  {addJsDefL name=freeShippingTranslation}{l s='Free shipping!' mod='blockcart' js=1}{/addJsDefL}
  {addJsDefL name=freeProductTranslation}{l s='Free!' mod='blockcart' js=1}{/addJsDefL}
  {addJsDefL name=delete_txt}{l s='Delete' mod='blockcart' js=1}{/addJsDefL}
  {addJsDefL name=toBeDetermined}{l s='To be determined' mod='blockcart' js=1}{/addJsDefL}
{/strip}
