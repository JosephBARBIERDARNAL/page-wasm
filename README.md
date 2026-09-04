# page-validation-wasm

JavaScript and TypeScript bindings to [`page`](https://josephbarbierdarnal.github.io/page/), a fast and lightweight PDF accessibility and compliance checker.

<br>

## Validate a PDF

```ts
import { validatePdfBytes } from "page-validation-wasm";

const bytes = new Uint8Array(await pdfFile.arrayBuffer());
const report = await validatePdfBytes(bytes);
console.log(report);

if (!report.isCompliant) {
  for (const failure of report.failures) {
    console.log(`[${failure.ruleId}] ${failure.message}`);
  }
}
```

`validatePdfBytes()` infers the PDF/A or PDF/UA profile from the document's XMP metadata. It throws `ValidationError` when the profile declaration is missing, malformed, or unsupported, or when the input cannot be read or parsed.

For a fast boolean result, use `isPdfCompliantBytes()`:

```ts
import { isPdfCompliantBytes } from "page-validation-wasm";

const isCompliant = await isPdfCompliantBytes(bytes);
console.log(isCompliant);
```

To select the profile yourself, use the explicit-profile variant:

```ts
import { ValidationProfile, validatePdfBytes } from "page-validation-wasm";

const report = await validatePdfBytes(bytes, ValidationProfile.PDF_A_1B);
```

The explicit-profile `validatePdfBytes()` call always returns a `ValidationReport`. Parser, operational, and conformance problems are represented in `report.failures`.

You can export the results as JSON with:

```ts
const json = report.toJson();
```

<br>

## Configure safety limits

All validation functions accept an optional `SafetyLimits` instance:

```ts
import { SafetyLimits, validatePdfBytes } from "page-validation-wasm";

const limits = new SafetyLimits({
  maxInputSize: 100 * 1024 * 1024,
  maxDecodedStreamSize: 32 * 1024 * 1024,
  maxTotalDecodedContentSize: 100 * 1024 * 1024,
  maxObjectCount: 500_000,
  maxReferenceDepth: 256,
  maxXrefRevisions: 1_024,
});

const report = await validatePdfBytes(bytes, undefined, limits);
```
