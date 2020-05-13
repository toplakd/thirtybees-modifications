<div class="paiement_block">
  <div id="HOOK_TOP_PAYMENT">{$HOOK_TOP_PAYMENT}</div>
  {if $HOOK_PAYMENT}
    {if !$opc}
        {include file="$tpl_dir./shopping-cart.tpl" cannotModify = 1 }
    {/if}
    {if $opc}
      <div id="opc_payment_methods-content">
    {/if}
    <div id="HOOK_PAYMENT">
      {$HOOK_PAYMENT}
    </div>
    {if $opc}
      </div>
    {/if}
  {else}
    <div class="alert alert-warning">{l s='No payment modules have been installed.'}</div>
  {/if}
  {if !$opc}
  <p class="cart_navigation clearfix">
    <a href="{$link->getPageLink('order', true, NULL, "step=2")|escape:'html':'UTF-8'}" title="{l s='Previous'}" class="btn btn-lg btn-default">
      <i class="icon icon-chevron-left"></i>
      {l s='Continue shopping'}
    </a>
  </p>
  {else}
</div>
{/if}
</div> {* end HOOK_TOP_PAYMENT *}
