# page-validation

WebAssembly and TypeScript bindings for [`page`](https://github.com/JosephBARBIERDARNAL/page), a fast and lightweight PDF accessibility and compliance checker.

## Validate PDF

```ts
import {
  ValidationProfile,
  isPdfCompliantBytes,
  validatePdfBytes,
} from "page-validation";

const bytes = new Uint8Array(await pdfFile.arrayBuffer());

// Validate a PDF and check its failures
const report = await validatePdfBytes(bytes, ValidationProfile.PDF_A_1B);
console.log(report.isCompliant, report.failures);

// Faster validation, but without failure details
const isCompliant = await isPdfCompliantBytes(bytes, ValidationProfile.PDF_A_1B);
```

The first call initializes the WebAssembly module automatically. Call `initialize()` during application startup if you want to control initialization explicitly. The byte APIs delegate to `page_validation::validate_pdf_bytes()` and `page_validation::is_pdf_compliant_bytes()`.

Pass no profile to infer it from the PDF's XMP metadata. Safety limits can be customized with `SafetyLimits` or a partial options object.
