<script lang="ts">
	import { user } from "$lib/stores";
</script>

<div class="flex flex-col justify-center items-center gap-2 p-6">
	<h1 class="text-feldgrau text-2xl font-bold">Under Construction</h1>
	<p class="text-lg">Current logged in user: {$user?.firstName}</p>
</div>
